import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../main/di/screens/define_focus_dependencies.dart';
import '../../../main/di/service_locator.dart';
import '../../../presenter/define_focus/define_focus_cubit.dart';
import '../../../presenter/define_focus/define_focus_state.dart';
import '../../shell/widgets/account_sheet.dart';
import '../widgets/define_focus_header.dart';
import 'view/define_focus_error_view.dart';
import 'view/define_focus_loading_view.dart';
import 'view/define_focus_view.dart';

/// Pops with `true` when the focus was saved so the caller can refresh.
class DefineFocusPage extends StatelessWidget {
  const DefineFocusPage({super.key});

  @override
  Widget build(BuildContext context) {
    setupDefineFocusDependencies();
    return BlocProvider<DefineFocusCubit>(
      create: (_) => getIt<DefineFocusCubit>()..load(),
      child: BlocConsumer<DefineFocusCubit, DefineFocusState>(
        listener: (context, state) {
          if (state is DefineFocusSaved) {
            Navigator.of(context).pop(true);
          }
        },
        builder: (context, state) {
          final cubit = context.read<DefineFocusCubit>();
          return Scaffold(
            appBar: DefineFocusHeader(
              onBack: () => Navigator.of(context).maybePop(),
              onAvatar: () => showAccountSheet(context),
            ),
            body: switch (state) {
              DefineFocusLoading() ||
              DefineFocusSaved() => const DefineFocusLoadingView(),
              DefineFocusError(:final message) => DefineFocusErrorView(
                message: message,
                onRetry: cubit.load,
              ),
              DefineFocusReady() => DefineFocusView(
                initialTitle: state.initialTitle,
                isSaving: state.isSaving,
                message: state.message,
                onSave: cubit.save,
                onCancel: () => Navigator.of(context).maybePop(),
              ),
            },
          );
        },
      ),
    );
  }
}
