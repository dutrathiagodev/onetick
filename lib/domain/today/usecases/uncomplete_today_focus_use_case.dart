import '../entities/focus_entity.dart';
import '../repositories/focus_repository.dart';

class UncompleteTodayFocusUseCase {
  const UncompleteTodayFocusUseCase(this._repository);

  final FocusRepository _repository;

  Future<FocusEntity> call() => _repository.uncompleteToday();
}
