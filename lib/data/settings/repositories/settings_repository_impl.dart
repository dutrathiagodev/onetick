import '../../../domain/settings/entities/app_settings.dart';
import '../../../domain/settings/repositories/settings_repository.dart';
import '../../../infra/adapters/focus/focus_remote_adapter.dart';
import '../../../infra/adapters/settings/settings_remote_adapter.dart';
import '../models/settings_model.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  const SettingsRepositoryImpl(this._settings, this._focus);

  final SettingsRemoteAdapter _settings;
  final FocusRemoteAdapter _focus;

  @override
  Future<AppSettings> load() async =>
      (await _settings.read())?.toEntity() ?? const AppSettings();

  @override
  Future<void> save(AppSettings settings) =>
      _settings.write(SettingsModel.fromEntity(settings));

  @override
  Future<void> clearHistory() => _focus.clearAll();
}
