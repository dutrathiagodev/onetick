import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/failures.dart';
import '../../../data/focus/models/focus_model.dart';
import 'focus_remote_adapter.dart';

/// Stores one document per day at `users/{uid}/focus/{yyyy-MM-dd}`.
class FirestoreFocusAdapter implements FocusRemoteAdapter {
  FirestoreFocusAdapter({
    required String Function() uidProvider,
    FirebaseFirestore? firestore,
  }) : _uid = uidProvider,
       _db = firestore ?? FirebaseFirestore.instance;

  final String Function() _uid;
  final FirebaseFirestore _db;

  CollectionReference<Map<String, dynamic>> get _collection =>
      _db.collection('users').doc(_uid()).collection('focus');

  @override
  Future<FocusModel?> getByKey(String dateKey) {
    return _guard(() async {
      final doc = _collection.doc(dateKey);
      final snap = await _read(doc.get, () => doc.get(_cacheOnly));
      final data = snap.data();
      return data == null ? null : _fromDoc(data);
    });
  }

  @override
  Future<void> upsert(FocusModel model) {
    return _guard(() async {
      final map = model.toMap();
      final at = model.completedAt;
      map['completedAt'] = at == null ? null : Timestamp.fromDate(at);
      await _commit(_collection.doc(model.dateKey).set(map));
    });
  }

  /// Offline, Firestore applies the write to the local cache at once but only
  /// completes the future after the server acknowledges it. Waiting forever
  /// would freeze the UI, so after a short wait the write is treated as queued.
  Future<void> _commit(Future<void> write) async {
    try {
      await write.timeout(_offline ? _offlineWait : _serverWait);
    } on TimeoutException {
      // Kept in the local cache and synced when the connection returns.
      _markOffline();
    }
  }

  static const _serverWait = Duration(seconds: 3);
  static const _offlineWait = Duration(milliseconds: 300);

  /// After a timeout, skip the server for a while so each tap doesn't pay
  /// the full wait again.
  DateTime? _offlineUntil;
  bool get _offline =>
      _offlineUntil != null && DateTime.now().isBefore(_offlineUntil!);
  void _markOffline() =>
      _offlineUntil = DateTime.now().add(const Duration(seconds: 30));

  static const _cacheOnly = GetOptions(source: Source.cache);

  /// Offline, a default read waits ~10s for the server before using the
  /// cache, leaving the screen on a spinner. Fall back to the cache sooner.
  Future<S> _read<S>(
    Future<S> Function() server,
    Future<S> Function() cache,
  ) async {
    if (_offline) return cache();
    try {
      final result = await server().timeout(_serverWait);
      _offlineUntil = null;
      return result;
    } on TimeoutException {
      _markOffline();
      return cache();
    }
  }

  @override
  Future<List<FocusModel>> range(String startKey, String endKey) {
    return _guard(() async {
      final query = _collection
          .where('dateKey', isGreaterThanOrEqualTo: startKey)
          .where('dateKey', isLessThanOrEqualTo: endKey);
      final snap = await _read(query.get, () => query.get(_cacheOnly));
      return snap.docs.map((d) => _fromDoc(d.data())).toList();
    });
  }

  @override
  Future<void> clearAll() {
    return _guard(() async {
      final snap = await _collection.get();
      for (var i = 0; i < snap.docs.length; i += 400) {
        final batch = _db.batch();
        for (final doc in snap.docs.skip(i).take(400)) {
          batch.delete(doc.reference);
        }
        await batch.commit();
      }
    });
  }

  FocusModel _fromDoc(Map<String, dynamic> data) {
    final raw = data['completedAt'];
    return FocusModel.fromMap({
      ...data,
      'completedAt': raw is Timestamp ? raw.toDate() : null,
    });
  }

  Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on AppFailure {
      rethrow;
    } on FirebaseException {
      throw const AppFailure(
        'Não foi possível sincronizar seus dados. Tente novamente.',
      );
    }
  }
}
