import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/failures.dart';
import '../../../data/settings/models/settings_model.dart';
import 'settings_remote_adapter.dart';

/// Preferences live at `users/{uid}/settings/prefs`.
class FirestoreSettingsAdapter implements SettingsRemoteAdapter {
  FirestoreSettingsAdapter({
    required String Function() uidProvider,
    FirebaseFirestore? firestore,
  }) : _uid = uidProvider,
       _db = firestore ?? FirebaseFirestore.instance;

  final String Function() _uid;
  final FirebaseFirestore _db;

  DocumentReference<Map<String, dynamic>> get _doc =>
      _db.collection('users').doc(_uid()).collection('settings').doc('prefs');

  @override
  Future<SettingsModel?> read() async {
    try {
      final data = (await _readSnapshot()).data();
      return data == null ? null : SettingsModel.fromMap(data);
    } on FirebaseException {
      throw const AppFailure('Não foi possível carregar suas configurações.');
    }
  }

  /// Offline, a default read waits ~10s for the server; use the cache sooner.
  Future<DocumentSnapshot<Map<String, dynamic>>> _readSnapshot() async {
    try {
      return await _doc.get().timeout(const Duration(seconds: 3));
    } on TimeoutException {
      return _doc.get(const GetOptions(source: Source.cache));
    }
  }

  @override
  Future<void> delete() async {
    try {
      await _doc.delete().timeout(const Duration(seconds: 4));
    } on TimeoutException {
      // Removed from the local cache; synced when the connection returns.
    } on FirebaseException {
      throw const AppFailure('Não foi possível apagar suas configurações.');
    }
  }

  @override
  Future<void> write(SettingsModel model) async {
    try {
      // Offline writes only complete on server ack; the local cache already
      // has the value, so a timeout means "queued", not "failed".
      await _doc.set(model.toMap()).timeout(const Duration(seconds: 4));
    } on TimeoutException {
      // Synced when the connection returns.
    } on FirebaseException {
      throw const AppFailure('Não foi possível salvar suas configurações.');
    }
  }
}
