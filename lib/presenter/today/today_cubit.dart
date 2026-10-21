import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/failures.dart';
import '../../domain/focus/usecases/complete_today_focus_use_case.dart';
import '../../domain/focus/usecases/get_streak_use_case.dart';
import '../../domain/focus/usecases/get_today_focus_use_case.dart';
import 'today_state.dart';

class TodayCubit extends Cubit<TodayState> {
  TodayCubit(this._getToday, this._complete, this._getStreak)
    : super(const TodayLoading());

  final GetTodayFocusUseCase _getToday;
  final CompleteTodayFocusUseCase _complete;
  final GetStreakUseCase _getStreak;

  Future<void> load() async {
    emit(const TodayLoading());
    try {
      final focus = await _getToday();
      final streak = await _getStreak();
      if (isClosed) return;
      if (focus == null) {
        emit(TodayEmpty(streak: streak));
      } else if (focus.completed) {
        emit(TodayCompleted(focus: focus, streak: streak));
      } else {
        emit(TodayPending(focus: focus, streak: streak));
      }
    } on AppFailure catch (e) {
      if (!isClosed) emit(TodayError(e.message));
    } catch (_) {
      if (!isClosed) {
        emit(const TodayError('Não foi possível carregar seu foco de hoje.'));
      }
    }
  }

  Future<void> complete() async {
    final current = state;
    if (current is! TodayPending || current.isCompleting) return;
    emit(
      TodayPending(
        focus: current.focus,
        streak: current.streak,
        isCompleting: true,
      ),
    );
    try {
      final done = await _complete();
      final streak = await _getStreak();
      if (!isClosed) emit(TodayCompleted(focus: done, streak: streak));
    } on AppFailure catch (e) {
      if (!isClosed) {
        emit(
          TodayPending(
            focus: current.focus,
            streak: current.streak,
            notice: e.message,
          ),
        );
      }
    } catch (_) {
      if (!isClosed) {
        emit(
          TodayPending(
            focus: current.focus,
            streak: current.streak,
            notice: 'Não foi possível concluir. Tente novamente.',
          ),
        );
      }
    }
  }
}
