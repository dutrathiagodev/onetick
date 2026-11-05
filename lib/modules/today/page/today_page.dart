import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/app_clock.dart';
import '../../../core/widgets/feedback.dart';
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
    return BlocProvider<TodayCubit>(
      create: (_) => getIt<TodayCubit>()..load(),
      child: _NewDayWatcher(
        child: BlocConsumer<TodayCubit, TodayState>(
          listenWhen: (previous, current) =>
              _noticeOf(current) != null &&
              _noticeOf(previous) != _noticeOf(current),
          listener: (context, state) {
            final notice = _noticeOf(state);
            if (notice != null) {
              showNotice(context, notice);
            }
          },
          builder: (context, state) {
            final cubit = context.read<TodayCubit>();
            // Read on every state so the header follows a reload at midnight.
            final today = getIt<AppClock>().now();
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
      ),
    );
  }
}

/// Coming back to the app on a new day (it stayed in the background
/// overnight) reloads Today instead of showing yesterday's focus.
class _NewDayWatcher extends StatefulWidget {
  const _NewDayWatcher({required this.child});

  final Widget child;

  @override
  State<_NewDayWatcher> createState() => _NewDayWatcherState();
}

class _NewDayWatcherState extends State<_NewDayWatcher> {
  late final AppLifecycleListener _lifecycle = AppLifecycleListener(
    onResume: () => context.read<TodayCubit>().refreshIfNewDay(),
  );

  @override
  void initState() {
    super.initState();
    _lifecycle;
  }

  @override
  void dispose() {
    _lifecycle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
