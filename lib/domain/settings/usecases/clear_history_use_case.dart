import '../repositories/settings_repository.dart';

class ClearHistoryUseCase {
  const ClearHistoryUseCase(this._repository);

  final SettingsRepository _repository;

  Future<void> call() => _repository.clearHistory();
}
