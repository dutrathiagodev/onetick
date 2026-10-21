import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../main/di/screens/history_dependencies.dart';
import '../../../main/di/service_locator.dart';
import '../../../presenter/history/history_cubit.dart';
import '../../../presenter/history/history_state.dart';
import 'view/history_empty_view.dart';
import 'view/history_error_view.dart';
import 'view/history_loading_view.dart';
import 'view/history_view.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    setupHistoryDependencies();
    return BlocProvider<HistoryCubit>(
      create: (_) => getIt<HistoryCubit>()..load(),
      child: BlocBuilder<HistoryCubit, HistoryState>(
        builder: (context, state) {
          final cubit = context.read<HistoryCubit>();
          return switch (state) {
            HistoryLoading() => const HistoryLoadingView(),
            HistoryError(:final message) => HistoryErrorView(
              message: message,
              onRetry: cubit.load,
            ),
            HistoryEmpty() => const HistoryEmptyView(),
            HistoryLoaded() => HistoryView(
              overview: state.overview,
              today: state.today,
              canGoNext: state.canGoNext,
              isRefreshing: state.isRefreshing,
              onPreviousMonth: cubit.previousMonth,
              onNextMonth: cubit.nextMonth,
            ),
          };
        },
      ),
    );
  }
}
