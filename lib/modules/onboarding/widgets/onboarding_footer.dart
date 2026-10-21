import 'package:flutter/material.dart';

import '../../../core/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/primary_pill_button.dart';

class OnboardingFooter extends StatelessWidget {
  const OnboardingFooter({
    super.key,
    required this.index,
    required this.count,
    required this.isLast,
    required this.onNext,
    required this.onLogin,
  });

  final int index;
  final int count;
  final bool isLast;
  final VoidCallback onNext;
  final VoidCallback onLogin;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < count; i++)
                AnimatedContainer(
                  key: Key('onboarding_dot_$i'),
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: i == index ? 28 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: i == index ? colors.inverse : colors.surfaceStronger,
                    borderRadius: BorderRadius.circular(9999),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 20),
          PrimaryPillButton(
            label: isLast ? 'Começar agora' : 'Avançar',
            iconAsset: AppAssets.arrowRight,
            onPressed: onNext,
            labelStyle: AppTextStyles.labelMedium.copyWith(
              letterSpacing: 0.325,
            ),
          ),
          const SizedBox(height: 14),
          TextButton(
            onPressed: onLogin,
            style: TextButton.styleFrom(
              minimumSize: const Size(48, 40),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              foregroundColor: colors.text,
            ),
            child: Text.rich(
              TextSpan(
                text: 'Já tem uma conta? ',
                style: AppTextStyles.labelMedium.copyWith(
                  color: colors.textMuted,
                ),
                children: [
                  TextSpan(
                    text: 'Entrar',
                    style: AppTextStyles.labelMedium.copyWith(
                      color: colors.text,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
