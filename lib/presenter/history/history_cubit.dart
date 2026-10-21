import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/failures.dart';
import '../../core/utils/date_utils.dart';
import '../../domain/history/usecases/get_history_overview_use_case.dart';
import 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit(this._getOverview, this._now) : super(const HistoryLoading());

  final GetHistoryOverviewUseCase _getOverview;
  final DateTime Function() _now;

  DateTime _month = DateTime(1970);

  Future<void> load() {
    final now = _now();
    _month = DateTime(now.year, now.month);
    return _fetch(initial: true);
  }

  Future<void> previousMonth() => _shift(-1);

  Future<void> nextMonth() => _shift(1);

  Future<void> _shift(int delta) async {
    final now = _now();
    final candidate = DateTime(_month.year, _month.month + delta);
    if (candidate.isAfter(DateTime(now.year, now.month))) return;
    _month = candidate;
    await _fetch(initial: false);
  }

  Future<void> _fetch({required bool initial}) async {
    final previous = state;
    if (initial || previous is! HistoryLoaded) {
      emit(const HistoryLoading());
    } else {
      emit(
        HistoryLoaded(
          overview: previous.overview,
          today: previous.today,
          canGoNext: previous.canGoNext,
          isRefreshing: true,
        ),
      );
    }
    try {
      final overview = await _getOverview(_month);
      if (isClosed) return;
      final now = _now();
      final today = DateUtilsX.dateOnly(now);
      final canGoNext = _month.isBefore(DateTime(now.year, now.month));
      final isFirstMonthView =
          _month.year == now.year && _month.month == now.month;
      if (overview.isEmpty && isFirstMonthView) {
        emit(const HistoryEmpty());
      } else {
        emit(
          HistoryLoaded(overview: overview, today: today, canGoNext: canGoNext),
        );
      }
    } on AppFailure catch (e) {
      if (!isClosed) emit(HistoryError(e.message));
    } catch (_) {
      if (!isClosed) {
        emit(const HistoryError('Não foi possível carregar o histórico.'));
      }
    }
  }
}
