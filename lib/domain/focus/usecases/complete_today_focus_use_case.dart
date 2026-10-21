import '../entities/focus_entity.dart';
import '../repositories/focus_repository.dart';

class CompleteTodayFocusUseCase {
  const CompleteTodayFocusUseCase(this._repository);

  final FocusRepository _repository;

  Future<FocusEntity> call() => _repository.completeToday();
}
