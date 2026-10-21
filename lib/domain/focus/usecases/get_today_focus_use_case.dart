import '../entities/focus_entity.dart';
import '../repositories/focus_repository.dart';

class GetTodayFocusUseCase {
  const GetTodayFocusUseCase(this._repository);

  final FocusRepository _repository;

  Future<FocusEntity?> call() => _repository.getToday();
}
