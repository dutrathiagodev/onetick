import '../repositories/focus_repository.dart';
import 'streak_calculator.dart';

class GetStreakUseCase {
  const GetStreakUseCase(this._repository, this._now);

  final FocusRepository _repository;
  final DateTime Function() _now;

  /// Look-back window; streaks longer than this are capped.
  static const int lookBackDays = 400;

  Future<int> call() async {
    final today = _now();
    final start = DateTime(today.year, today.month, today.day - lookBackDays);
    final entries = await _repository.entriesBetween(start, today);
    return StreakCalculator.calculate(entries, today);
  }
}
