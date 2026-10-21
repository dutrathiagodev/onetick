import 'package:equatable/equatable.dart';

import 'history_day.dart';

class HistoryOverview extends Equatable {
  const HistoryOverview({
    required this.month,
    required this.completedDays,
    required this.completedCount,
    required this.activeDays,
    required this.successRate,
    required this.streak,
    required this.recentDays,
  });

  /// First day of the month being displayed.
  final DateTime month;

  /// Day-of-month numbers (1..31) completed in [month].
  final Set<int> completedDays;
  final int completedCount;

  /// Days of [month] that already happened (denominator of the success rate).
  final int activeDays;

  /// 0..100.
  final int successRate;
  final int streak;

  /// Last 7 days, newest first.
  final List<HistoryDay> recentDays;

  bool get isEmpty =>
      completedCount == 0 && recentDays.every((d) => d.entry == null);

  @override
  List<Object?> get props => [
    month,
    completedDays,
    completedCount,
    activeDays,
    successRate,
    streak,
    recentDays,
  ];
}
