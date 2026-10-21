import 'package:flutter_test/flutter_test.dart';
import 'package:onetick/domain/focus/entities/focus_entity.dart';
import 'package:onetick/domain/focus/usecases/streak_calculator.dart';

FocusEntity done(String key) =>
    FocusEntity(dateKey: key, title: 't', completed: true);
FocusEntity pending(String key) => FocusEntity(dateKey: key, title: 't');

void main() {
  final today = DateTime(2024, 10, 30);

  test('no entries -> 0', () {
    expect(StreakCalculator.calculate(const [], today), 0);
  });

  test('counts consecutive days ending today', () {
    final entries = [
      done('2024-10-30'),
      done('2024-10-29'),
      done('2024-10-28'),
    ];
    expect(StreakCalculator.calculate(entries, today), 3);
  });

  test('keeps streak alive when today is still pending', () {
    final entries = [
      pending('2024-10-30'),
      done('2024-10-29'),
      done('2024-10-28'),
    ];
    expect(StreakCalculator.calculate(entries, today), 2);
  });

  test('a gap breaks the streak', () {
    final entries = [
      done('2024-10-30'),
      done('2024-10-28'),
      done('2024-10-27'),
    ];
    expect(StreakCalculator.calculate(entries, today), 1);
  });

  test('crosses month and year boundaries', () {
    final entries = [
      done('2025-01-01'),
      done('2024-12-31'),
      done('2024-12-30'),
    ];
    expect(StreakCalculator.calculate(entries, DateTime(2025, 1, 1)), 3);
  });

  test('last completed day two days ago -> 0', () {
    expect(StreakCalculator.calculate([done('2024-10-28')], today), 0);
  });
}
