import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/dot_pill.dart';

class OnboardingHeader extends StatelessWidget {
  const OnboardingHeader({
    super.key,
    required this.current,
    required this.total,
    required this.onSkip,
  });

  final int current;
  final int total;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DotPill(
            label: '$current DE $total',
            background: colors.surfaceMuted,
            textStyle: AppTextStyles.caption.copyWith(
              color: colors.text,
              letterSpacing: 1.1,
            ),
          ),
          TextButton(
            onPressed: onSkip,
            style: TextButton.styleFrom(
              minimumSize: const Size(48, 40),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              shape: const StadiumBorder(),
            ),
            child: Text(
              'Pular',
              style: AppTextStyles.labelMedium.copyWith(
                color: colors.textMuted,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
