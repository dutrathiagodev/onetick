import '../../../core/utils/date_utils.dart';
import '../../focus/entities/focus_entity.dart';
import '../../focus/usecases/get_streak_use_case.dart';
import '../../focus/usecases/streak_calculator.dart';
import '../entities/history_day.dart';
import '../entities/history_overview.dart';
import '../repositories/history_repository.dart';

class GetHistoryOverviewUseCase {
  const GetHistoryOverviewUseCase(this._repository, this._now);

  final HistoryRepository _repository;
  final DateTime Function() _now;

  Future<HistoryOverview> call(DateTime month) async {
    final today = DateUtilsX.dateOnly(_now());
    final firstOfMonth = DateTime(month.year, month.month);
    final lastOfMonth = DateTime(
      month.year,
      month.month,
      DateUtilsX.daysInMonth(month.year, month.month),
    );

    final lookBackStart = DateTime(
      today.year,
      today.month,
      today.day - GetStreakUseCase.lookBackDays,
    );

    final monthEntries = await _repository.entriesBetween(
      firstOfMonth,
      lastOfMonth,
    );
    final streakEntries = await _repository.entriesBetween(
      lookBackStart,
      today,
    );

    final completedDays = {
      for (final e in monthEntries)
        if (e.completed) DateUtilsX.parseKey(e.dateKey).day,
    };

    final activeDays = _activeDays(month, today);
    final successRate = activeDays == 0
        ? 0
        : ((completedDays.length / activeDays) * 100).round().clamp(0, 100);

    final byKey = <String, FocusEntity>{
      for (final e in streakEntries) e.dateKey: e,
    };
    final recent = [
      for (var i = 0; i < 7; i++)
        () {
          final date = DateTime(today.year, today.month, today.day - i);
          return HistoryDay(date: date, entry: byKey[DateUtilsX.keyOf(date)]);
        }(),
    ];

    return HistoryOverview(
      month: firstOfMonth,
      completedDays: completedDays,
      completedCount: completedDays.length,
      activeDays: activeDays,
      successRate: successRate,
      streak: StreakCalculator.calculate(streakEntries, today),
      recentDays: recent,
    );
  }

  int _activeDays(DateTime month, DateTime today) {
    final total = DateUtilsX.daysInMonth(month.year, month.month);
    if (month.year == today.year && month.month == today.month) {
      return today.day;
    }
    final monthStart = DateTime(month.year, month.month);
    final todayMonthStart = DateTime(today.year, today.month);
    return monthStart.isBefore(todayMonthStart) ? total : 0;
  }
}
