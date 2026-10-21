import 'package:equatable/equatable.dart';

import '../../domain/settings/entities/app_settings.dart';

sealed class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object?> get props => [];
}

class SettingsLoading extends SettingsState {
  const SettingsLoading();
}

class SettingsError extends SettingsState {
  const SettingsError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

class SettingsLoaded extends SettingsState {
  const SettingsLoaded({
    required this.settings,
    this.isBusy = false,
    this.notice,
    this.noticeId = 0,
  });

  final AppSettings settings;
  final bool isBusy;

  /// One-shot message for a SnackBar; [noticeId] changes for every new notice.
  final String? notice;
  final int noticeId;

  SettingsLoaded copyWith({
    AppSettings? settings,
    bool? isBusy,
    String? notice,
    int? noticeId,
  }) {
    return SettingsLoaded(
      settings: settings ?? this.settings,
      isBusy: isBusy ?? this.isBusy,
      notice: notice,
      noticeId: noticeId ?? this.noticeId,
    );
  }

  @override
  List<Object?> get props => [settings, isBusy, notice, noticeId];
}
