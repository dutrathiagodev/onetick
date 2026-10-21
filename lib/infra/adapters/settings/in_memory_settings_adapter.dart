import '../../../data/settings/models/settings_model.dart';
import 'settings_remote_adapter.dart';

class InMemorySettingsAdapter implements SettingsRemoteAdapter {
  SettingsModel? _model;

  @override
  Future<SettingsModel?> read() async => _model;

  @override
  Future<void> write(SettingsModel model) async => _model = model;
}
