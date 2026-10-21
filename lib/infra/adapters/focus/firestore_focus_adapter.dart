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
      final snap = await _collection.doc(dateKey).get();
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
      await _collection.doc(model.dateKey).set(map);
    });
  }

  @override
  Future<List<FocusModel>> range(String startKey, String endKey) {
    return _guard(() async {
      final snap = await _collection
          .where('dateKey', isGreaterThanOrEqualTo: startKey)
          .where('dateKey', isLessThanOrEqualTo: endKey)
          .get();
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
