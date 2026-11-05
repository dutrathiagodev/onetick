import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// One-shot message at the bottom of the screen, replacing the current one.
void showNotice(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}

/// Confirmation for irreversible actions; the confirm button is red.
/// Buttons are keyed `<keyPrefix>_cancel` / `<keyPrefix>_confirm`.
Future<bool> showDangerConfirm(
  BuildContext context, {
  required String title,
  required String message,
  required String action,
  required String keyPrefix,
}) async {
  final colors = context.colors;
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      backgroundColor: colors.surface,
      title: Text(
        title,
        style: AppTextStyles.subtitle.copyWith(color: colors.text),
      ),
      content: Text(
        message,
        style: AppTextStyles.label.copyWith(color: colors.textMuted),
      ),
      actions: [
        TextButton(
          key: Key('${keyPrefix}_cancel'),
          onPressed: () => Navigator.of(dialogContext).pop(false),
          child: Text(
            'Cancelar',
            style: AppTextStyles.labelMedium.copyWith(color: colors.textMuted),
          ),
        ),
        TextButton(
          key: Key('${keyPrefix}_confirm'),
          onPressed: () => Navigator.of(dialogContext).pop(true),
          child: Text(
            action,
            style: AppTextStyles.labelMedium.copyWith(color: colors.danger),
          ),
        ),
      ],
    ),
  );
  return confirmed ?? false;
}
