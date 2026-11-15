import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

/// Top row of the onboarding: only the "Pular" link. The step is shown by the
/// dots above the CTA, so a "1 DE 3" badge would repeat the same information.
class OnboardingHeader extends StatelessWidget {
  const OnboardingHeader({super.key, required this.onSkip});

  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          onPressed: onSkip,
          style: TextButton.styleFrom(
            minimumSize: const Size(48, 40),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            shape: const StadiumBorder(),
          ),
          child: Text(
            'Pular',
            style: AppTextStyles.labelMedium.copyWith(color: colors.textMuted),
          ),
        ),
      ),
    );
  }
}
