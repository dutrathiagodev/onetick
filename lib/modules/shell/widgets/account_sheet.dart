import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../presenter/session/session_cubit.dart';
import '../../../presenter/session/session_state.dart';

/// Bottom sheet opened by the avatar button: who is signed in + sign out.
Future<void> showAccountSheet(BuildContext context) {
  final session = context.read<SessionCubit>();
  return showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    backgroundColor: context.colors.surface,
    builder: (sheetContext) => _AccountSheet(
      state: session.state,
      onSignOut: () async {
        Navigator.of(sheetContext).pop();
        await session.signOut();
      },
    ),
  );
}

class _AccountSheet extends StatelessWidget {
  const _AccountSheet({required this.state, required this.onSignOut});

  final SessionState state;
  final VoidCallback onSignOut;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final user = state is SessionAuthenticated
        ? (state as SessionAuthenticated).user
        : null;
    final name = (user?.name?.trim().isNotEmpty ?? false)
        ? user!.name!
        : 'Sua conta';
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: AppTextStyles.subtitle.copyWith(color: colors.text),
            ),
            if (user != null) ...[
              const SizedBox(height: 2),
              Text(
                user.email,
                style: AppTextStyles.label.copyWith(color: colors.textMuted),
              ),
            ],
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                key: const Key('account_sign_out'),
                onPressed: onSignOut,
                style: OutlinedButton.styleFrom(
                  foregroundColor: colors.danger,
                  side: BorderSide(color: colors.border),
                  shape: const StadiumBorder(),
                  minimumSize: const Size.fromHeight(48),
                ),
                child: Text(
                  'Sair da conta',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: colors.danger,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
