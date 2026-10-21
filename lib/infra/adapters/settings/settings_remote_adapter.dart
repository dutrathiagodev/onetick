import '../../../data/settings/models/settings_model.dart';

abstract interface class SettingsRemoteAdapter {
  Future<SettingsModel?> read();

  Future<void> write(SettingsModel model);
}
