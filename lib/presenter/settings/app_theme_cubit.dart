import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/settings/entities/app_settings.dart';
import '../../domain/settings/usecases/get_settings_use_case.dart';

/// App-wide [ThemeMode], restored from the user's saved preferences.
class AppThemeCubit extends Cubit<ThemeMode> {
  AppThemeCubit(this._getSettings) : super(ThemeMode.light);

  final GetSettingsUseCase _getSettings;

  Future<void> restore() async {
    try {
      apply((await _getSettings()).theme);
    } catch (_) {
      // Keep the current theme if preferences cannot be read.
    }
  }

  void apply(AppThemePreference preference) {
    emit(
      preference == AppThemePreference.dark ? ThemeMode.dark : ThemeMode.light,
    );
  }

  void reset() => emit(ThemeMode.light);
}
