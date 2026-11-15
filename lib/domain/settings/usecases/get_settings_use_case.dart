import '../entities/app_settings_entity.dart';
import '../repositories/settings_repository.dart';

class GetSettingsUseCase {
  const GetSettingsUseCase(this._repository);

  final SettingsRepository _repository;

  Future<AppSettings> call() => _repository.load();
}
