import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/failures.dart';
import '../../domain/focus/usecases/get_today_focus_use_case.dart';
import '../../domain/focus/usecases/save_today_focus_use_case.dart';
import 'define_focus_state.dart';

class DefineFocusCubit extends Cubit<DefineFocusState> {
  DefineFocusCubit(this._getToday, this._save)
    : super(const DefineFocusLoading());

  final GetTodayFocusUseCase _getToday;
  final SaveTodayFocusUseCase _save;

  Future<void> load() async {
    emit(const DefineFocusLoading());
    try {
      final focus = await _getToday();
      if (!isClosed) emit(DefineFocusReady(initialTitle: focus?.title ?? ''));
    } on AppFailure catch (e) {
      if (!isClosed) emit(DefineFocusError(e.message));
    } catch (_) {
      if (!isClosed) {
        emit(const DefineFocusError('Não foi possível carregar seu foco.'));
      }
    }
  }

  Future<void> save(String title) async {
    final current = state;
    if (current is! DefineFocusReady || current.isSaving) return;
    emit(DefineFocusReady(initialTitle: current.initialTitle, isSaving: true));
    try {
      await _save(title);
      if (!isClosed) emit(const DefineFocusSaved());
    } on AppFailure catch (e) {
      if (!isClosed) {
        emit(
          DefineFocusReady(
            initialTitle: current.initialTitle,
            message: e.message,
          ),
        );
      }
    } catch (_) {
      if (!isClosed) {
        emit(
          DefineFocusReady(
            initialTitle: current.initialTitle,
            message: 'Não foi possível salvar. Tente novamente.',
          ),
        );
      }
    }
  }
}
