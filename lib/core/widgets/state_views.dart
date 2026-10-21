import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import 'app_icon.dart';
import 'primary_pill_button.dart';

/// Generic loading placeholder reused by every feature's `*_loading_view`.
class LoadingStateView extends StatelessWidget {
  const LoadingStateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        key: const Key('loading_indicator'),
        strokeWidth: 2.5,
        color: context.colors.brand,
      ),
    );
  }
}

/// Generic error placeholder with a retry action.
class ErrorStateView extends StatelessWidget {
  const ErrorStateView({
    super.key,
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Ops, algo deu errado',
              style: AppTextStyles.subtitle.copyWith(color: colors.text),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.label.copyWith(color: colors.textMuted),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: 220,
              child: PrimaryPillButton(
                label: 'Tentar novamente',
                onPressed: onRetry,
                height: 48,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Generic empty placeholder (icon + title + body + optional action).
class EmptyStateView extends StatelessWidget {
  const EmptyStateView({
    super.key,
    required this.iconAsset,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
  });

  final String iconAsset;
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: colors.mint,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: AppIcon(iconAsset, tint: colors.brand),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.title.copyWith(color: colors.text),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.label.copyWith(color: colors.textMuted),
            ),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 24),
              SizedBox(
                width: 240,
                child: PrimaryPillButton(
                  label: actionLabel!,
                  onPressed: onAction,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
