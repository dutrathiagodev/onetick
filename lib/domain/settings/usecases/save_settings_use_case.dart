import '../entities/app_settings_entity.dart';
import '../repositories/settings_repository.dart';

class SaveSettingsUseCase {
  const SaveSettingsUseCase(this._repository);

  final SettingsRepository _repository;

  Future<void> call(AppSettings settings) => _repository.save(settings);
}
