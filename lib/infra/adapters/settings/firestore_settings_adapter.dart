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
      final data = (await _doc.get()).data();
      return data == null ? null : SettingsModel.fromMap(data);
    } on FirebaseException {
      throw const AppFailure('Não foi possível carregar suas configurações.');
    }
  }

  @override
  Future<void> write(SettingsModel model) async {
    try {
      await _doc.set(model.toMap());
    } on FirebaseException {
      throw const AppFailure('Não foi possível salvar suas configurações.');
    }
  }
}
