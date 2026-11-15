import '../entities/focus_entity.dart';
import '../repositories/focus_repository.dart';
import 'focus_title_validator.dart';

class SaveTodayFocusUseCase {
  const SaveTodayFocusUseCase(this._repository);

  final FocusRepository _repository;

  Future<FocusEntity> call(String title) {
    return _repository.saveToday(FocusTitleValidator.validate(title));
  }
}
