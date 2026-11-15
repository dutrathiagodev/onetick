import '../entities/focus_entity.dart';

abstract interface class FocusRepository {
  Future<FocusEntity?> getToday();

  /// Creates or replaces today's focus. Replacing resets completion.
  Future<FocusEntity> saveToday(String title);

  Future<FocusEntity> completeToday();

  /// Undoes today's completion (the focus text is kept).
  Future<FocusEntity> uncompleteToday();

  Future<List<FocusEntity>> entriesBetween(DateTime start, DateTime end);
}
