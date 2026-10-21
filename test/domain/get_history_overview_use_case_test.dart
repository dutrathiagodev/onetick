import 'package:flutter_test/flutter_test.dart';
import 'package:onetick/data/history/repositories/history_repository_impl.dart';
import 'package:onetick/domain/history/usecases/get_history_overview_use_case.dart';
import 'package:onetick/infra/adapters/focus/in_memory_focus_adapter.dart';

import '../helpers/test_setup.dart';

void main() {
  final now = DateTime(2024, 10, 30, 14);

  GetHistoryOverviewUseCase build(InMemoryFocusAdapter adapter) =>
      GetHistoryOverviewUseCase(HistoryRepositoryImpl(adapter), () => now);

  test(
    'current month: counts completed days and rate over elapsed days',
    () async {
      final adapter = InMemoryFocusAdapter([
        for (final d in [1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
          focusOn(DateTime(2024, 10, d), 'Foco $d'),
        focusOn(DateTime(2024, 10, 11), 'Pendente', completed: false),
      ]);
      final overview = await build(adapter)(DateTime(2024, 10));
      expect(overview.completedCount, 10);
      expect(overview.activeDays, 30);
      expect(overview.successRate, 33);
      expect(overview.completedDays, containsAll([1, 5, 10]));
      expect(overview.completedDays, isNot(contains(11)));
    },
  );

  test('past month uses its full length as denominator', () async {
    final adapter = InMemoryFocusAdapter([
      for (var d = 1; d <= 15; d++) focusOn(DateTime(2024, 9, d), 'x'),
    ]);
    final overview = await build(adapter)(DateTime(2024, 9));
    expect(overview.activeDays, 30);
    expect(overview.successRate, 50);
  });

  test(
    'streak and recent days (newest first, rest days have no entry)',
    () async {
      final adapter = InMemoryFocusAdapter([
        focusOn(DateTime(2024, 10, 30), 'Hoje'),
        focusOn(DateTime(2024, 10, 29), 'Ontem'),
        focusOn(DateTime(2024, 10, 27), 'Domingo'),
      ]);
      final overview = await build(adapter)(DateTime(2024, 10));
      expect(overview.streak, 2);
      expect(overview.recentDays, hasLength(7));
      expect(overview.recentDays.first.date, DateTime(2024, 10, 30));
      expect(overview.recentDays[1].entry?.title, 'Ontem');
      expect(overview.recentDays[2].entry, isNull);
      expect(overview.recentDays.last.date, DateTime(2024, 10, 24));
    },
  );

  test('empty data', () async {
    final overview = await build(InMemoryFocusAdapter())(DateTime(2024, 10));
    expect(overview.isEmpty, isTrue);
    expect(overview.successRate, 0);
    expect(overview.streak, 0);
  });

  test(
    'month in the future has zero active days (no division by zero)',
    () async {
      final overview = await build(InMemoryFocusAdapter())(DateTime(2024, 12));
      expect(overview.activeDays, 0);
      expect(overview.successRate, 0);
    },
  );
}
