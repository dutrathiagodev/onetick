import 'package:equatable/equatable.dart';

enum AppThemePreference { light, dark }

class AppSettings extends Equatable {
  const AppSettings({
    this.reminderEnabled = true,
    this.reminderHour = 9,
    this.reminderMinute = 0,
    this.theme = AppThemePreference.light,
  });

  final bool reminderEnabled;
  final int reminderHour;
  final int reminderMinute;
  final AppThemePreference theme;

  String get reminderLabel =>
      '${reminderHour.toString().padLeft(2, '0')}:${reminderMinute.toString().padLeft(2, '0')}';

  AppSettings copyWith({
    bool? reminderEnabled,
    int? reminderHour,
    int? reminderMinute,
    AppThemePreference? theme,
  }) {
    return AppSettings(
      reminderEnabled: reminderEnabled ?? this.reminderEnabled,
      reminderHour: reminderHour ?? this.reminderHour,
      reminderMinute: reminderMinute ?? this.reminderMinute,
      theme: theme ?? this.theme,
    );
  }

  @override
  List<Object?> get props => [
    reminderEnabled,
    reminderHour,
    reminderMinute,
    theme,
  ];
}
