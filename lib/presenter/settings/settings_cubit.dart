import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/failures.dart';
import '../../domain/settings/entities/app_settings.dart';
import '../../domain/settings/usecases/clear_history_use_case.dart';
import '../../domain/settings/usecases/get_settings_use_case.dart';
import '../../domain/settings/usecases/save_settings_use_case.dart';
import '../../domain/settings/usecases/sync_reminder_use_case.dart';
import 'app_theme_cubit.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(
    this._get,
    this._save,
    this._clear,
    this._themeCubit,
    this._syncReminder,
  ) : super(const SettingsLoading());

  final GetSettingsUseCase _get;
  final SaveSettingsUseCase _save;
  final ClearHistoryUseCase _clear;
  final AppThemeCubit _themeCubit;
  final SyncReminderUseCase _syncReminder;

  Future<void> load() async {
    emit(const SettingsLoading());
    try {
      final settings = await _get();
      if (!isClosed) emit(SettingsLoaded(settings: settings));
    } on AppFailure catch (e) {
      if (!isClosed) emit(SettingsError(e.message));
    } catch (_) {
      if (!isClosed) {
        emit(
          const SettingsError('Não foi possível carregar suas configurações.'),
        );
      }
    }
  }

  Future<void> setReminderEnabled(bool enabled) =>
      _changeReminder((s) => s.copyWith(reminderEnabled: enabled));

  Future<void> setReminderTime(int hour, int minute) => _changeReminder(
    (s) => s.copyWith(reminderHour: hour, reminderMinute: minute),
  );

  Future<void> setTheme(AppThemePreference theme) async {
    final applied = await _update((s) => s.copyWith(theme: theme));
    if (applied) _themeCubit.apply(theme);
  }

  Future<void> clearHistory() async {
    final current = state;
    if (current is! SettingsLoaded || current.isBusy) return;
    emit(current.copyWith(isBusy: true));
    try {
      await _clear();
      if (!isClosed) {
        emit(
          current.copyWith(
            notice: 'Histórico e hábitos apagados.',
            noticeId: current.noticeId + 1,
          ),
        );
      }
    } on AppFailure catch (e) {
      if (!isClosed) {
        emit(
          current.copyWith(notice: e.message, noticeId: current.noticeId + 1),
        );
      }
    } catch (_) {
      if (!isClosed) {
        emit(
          current.copyWith(
            notice: 'Não foi possível apagar os dados.',
            noticeId: current.noticeId + 1,
          ),
        );
      }
    }
  }

  /// Schedules the notification first, so a denied permission never leaves
  /// the switch on without a reminder behind it.
  Future<void> _changeReminder(AppSettings Function(AppSettings) change) async {
    final current = state;
    if (current is! SettingsLoaded) return;
    try {
      if (!await _syncReminder(change(current.settings))) {
        _notify(
          current,
          'Permita as notificações do OneTick nas configurações do aparelho '
          'para receber o lembrete.',
        );
        return;
      }
    } catch (_) {
      _notify(current, 'Não foi possível agendar o lembrete.');
      return;
    }
    await _update(change);
  }

  void _notify(SettingsLoaded current, String message) {
    if (isClosed) return;
    emit(current.copyWith(notice: message, noticeId: current.noticeId + 1));
  }

  /// Optimistic update; rolls back and reports when saving fails.
  Future<bool> _update(AppSettings Function(AppSettings) change) async {
    final current = state;
    if (current is! SettingsLoaded) return false;
    final next = change(current.settings);
    emit(current.copyWith(settings: next));
    try {
      await _save(next);
      return true;
    } catch (_) {
      if (!isClosed) {
        emit(
          current.copyWith(
            notice: 'Não foi possível salvar a alteração.',
            noticeId: current.noticeId + 1,
          ),
        );
      }
      return false;
    }
  }
}
