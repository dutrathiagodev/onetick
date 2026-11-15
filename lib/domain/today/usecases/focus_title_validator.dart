import '../../../core/failures.dart';
import '../entities/focus_entity.dart';

abstract final class FocusTitleValidator {
  static String validate(String raw) {
    final value = raw.trim();
    if (value.isEmpty) throw const AppFailure('Escreva o seu foco para hoje.');
    if (value.length > FocusEntity.maxTitleLength) {
      throw const AppFailure('O foco pode ter no máximo 60 caracteres.');
    }
    return value;
  }
}
