import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/app_clock.dart';
import '../../../main/di/screens/today_dependencies.dart';
import '../../../main/di/service_locator.dart';
import '../../../presenter/shell/shell_cubit.dart';
import '../../../presenter/today/today_cubit.dart';
import '../../../presenter/today/today_state.dart';
import '../../define_focus/page/define_focus_page.dart';
import 'view/today_completed_view.dart';
import 'view/today_empty_view.dart';
import 'view/today_error_view.dart';
import 'view/today_loading_view.dart';
import 'view/today_view.dart';

class TodayPage extends StatelessWidget {
  const TodayPage({super.key});

  Future<void> _openDefineFocus(BuildContext context) async {
    final cubit = context.read<TodayCubit>();
    final saved = await Navigator.of(context)
        .push<bool>(MaterialPageRoute(builder: (_) => const DefineFocusPage()));
    if (saved == true) {
      await cubit.load();
    }
  }

  static String? _noticeOf(TodayState state) => switch (state) {
    TodayPending(:final notice) => notice,
    TodayCompleted(:final notice) => notice,
    _ => null,
  };

  @override
  Widget build(BuildContext context) {
    setupTodayDependencies();
    final today = getIt<AppClock>().now();
    return BlocProvider<TodayCubit>(
      create: (_) => getIt<TodayCubit>()..load(),
      child: BlocConsumer<TodayCubit, TodayState>(
        listenWhen: (previous, current) =>
            _noticeOf(current) != null &&
            _noticeOf(previous) != _noticeOf(current),
        listener: (context, state) {
          final notice = _noticeOf(state);
          if (notice != null) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(notice)));
          }
        },
        builder: (context, state) {
          final cubit = context.read<TodayCubit>();
          return switch (state) {
            TodayLoading() => const TodayLoadingView(),
            TodayError(:final message) => TodayErrorView(
              message: message,
              onRetry: cubit.load,
            ),
            TodayEmpty(:final streak) => TodayEmptyView(
              today: today,
              streak: streak,
              onDefineFocus: () => _openDefineFocus(context),
            ),
            TodayPending() => TodayView(
              today: today,
              focus: state.focus,
              streak: state.streak,
              isCompleting: state.isCompleting,
              onComplete: cubit.complete,
              onChangeFocus: () => _openDefineFocus(context),
            ),
            TodayCompleted() => TodayCompletedView(
              today: today,
              focus: state.focus,
              streak: state.streak,
              isUndoing: state.isUndoing,
              onSeeHistory: () =>
                  context.read<ShellCubit>().select(HomeTab.history),
              onUndo: cubit.undoCompletion,
            ),
          };
        },
      ),
    );
  }
}
