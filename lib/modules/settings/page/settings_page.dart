import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../main/di/screens/settings_dependencies.dart';
import '../../../main/di/service_locator.dart';
import '../../../presenter/settings/settings_cubit.dart';
import '../../../presenter/settings/settings_state.dart';
import 'view/settings_error_view.dart';
import 'view/settings_loading_view.dart';
import 'view/settings_view.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    setupSettingsDependencies();
    return BlocProvider<SettingsCubit>(
      create: (_) => getIt<SettingsCubit>()..load(),
      child: BlocConsumer<SettingsCubit, SettingsState>(
        listenWhen: (previous, current) =>
            current is SettingsLoaded &&
            current.notice != null &&
            (previous is! SettingsLoaded ||
                previous.noticeId != current.noticeId),
        listener: (context, state) {
          if (state is SettingsLoaded && state.notice != null) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(state.notice!)));
          }
        },
        builder: (context, state) {
          final cubit = context.read<SettingsCubit>();
          return switch (state) {
            SettingsLoading() => const SettingsLoadingView(),
            SettingsError(:final message) => SettingsErrorView(
              message: message,
              onRetry: cubit.load,
            ),
            SettingsLoaded() => SettingsView(
              settings: state.settings,
              isBusy: state.isBusy,
              onReminderChanged: cubit.setReminderEnabled,
              onReminderTimeChanged: cubit.setReminderTime,
              onThemeChanged: cubit.setTheme,
              onClearHistory: cubit.clearHistory,
            ),
          };
        },
      ),
    );
  }
}
