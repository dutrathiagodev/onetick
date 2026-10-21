import '../../../core/utils/date_utils.dart';
import '../entities/focus_entity.dart';

/// Counts consecutive completed days ending today (or yesterday when today is
/// still pending, so the streak is not lost before the day is over).
abstract final class StreakCalculator {
  static int calculate(Iterable<FocusEntity> entries, DateTime today) {
    final completed = {
      for (final e in entries)
        if (e.completed) e.dateKey,
    };
    var cursor = DateUtilsX.dateOnly(today);
    if (!completed.contains(DateUtilsX.keyOf(cursor))) {
      cursor = cursor.subtract(const Duration(days: 1));
    }
    var streak = 0;
    while (completed.contains(DateUtilsX.keyOf(cursor))) {
      streak++;
      cursor = DateTime(cursor.year, cursor.month, cursor.day - 1);
    }
    return streak;
  }
}
