import '../../focus/entities/focus_entity.dart';

abstract interface class HistoryRepository {
  Future<List<FocusEntity>> entriesBetween(DateTime start, DateTime end);
}
