import '../../../domain/settings/entities/app_settings.dart';

class SettingsModel {
  const SettingsModel({
    required this.reminderEnabled,
    required this.reminderHour,
    required this.reminderMinute,
    required this.theme,
  });

  final bool reminderEnabled;
  final int reminderHour;
  final int reminderMinute;
  final String theme;

  factory SettingsModel.fromMap(Map<String, dynamic> map) {
    return SettingsModel(
      reminderEnabled: (map['reminderEnabled'] as bool?) ?? true,
      reminderHour: (map['reminderHour'] as num?)?.toInt() ?? 9,
      reminderMinute: (map['reminderMinute'] as num?)?.toInt() ?? 0,
      theme: (map['theme'] as String?) ?? 'light',
    );
  }

  factory SettingsModel.fromEntity(AppSettings settings) {
    return SettingsModel(
      reminderEnabled: settings.reminderEnabled,
      reminderHour: settings.reminderHour,
      reminderMinute: settings.reminderMinute,
      theme: settings.theme.name,
    );
  }

  Map<String, dynamic> toMap() => {
    'reminderEnabled': reminderEnabled,
    'reminderHour': reminderHour,
    'reminderMinute': reminderMinute,
    'theme': theme,
  };

  AppSettings toEntity() {
    return AppSettings(
      reminderEnabled: reminderEnabled,
      reminderHour: reminderHour.clamp(0, 23),
      reminderMinute: reminderMinute.clamp(0, 59),
      theme: theme == 'dark'
          ? AppThemePreference.dark
          : AppThemePreference.light,
    );
  }
}
