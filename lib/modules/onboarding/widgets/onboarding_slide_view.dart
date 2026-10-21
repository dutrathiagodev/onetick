import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../domain/onboarding/entities/onboarding_slide.dart';
import 'onboarding_art_celebrate.dart';
import 'onboarding_art_less_noise.dart';
import 'onboarding_art_one_priority.dart';

/// One carousel page: illustration card + heading + description, vertically
/// centered and scrollable so small screens never overflow.
class OnboardingSlideView extends StatelessWidget {
  const OnboardingSlideView({super.key, required this.slide});

  final OnboardingSlide slide;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isCelebrate = slide.kind == OnboardingSlideKind.celebrate;
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _art(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    slide.title,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.headline.copyWith(color: colors.text),
                  ),
                ),
                SizedBox(height: isCelebrate ? 12 : 8),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isCelebrate ? 24 : 16,
                  ),
                  child: Text(
                    slide.description,
                    textAlign: TextAlign.center,
                    style:
                        (isCelebrate
                                ? AppTextStyles.bodyLarge
                                : AppTextStyles.body)
                            .copyWith(
                              color: colors.textMuted,
                              height: isCelebrate ? 27.63 / 17 : 24.38 / 15,
                            ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _art() {
    return switch (slide.kind) {
      OnboardingSlideKind.lessNoise => const Padding(
        padding: EdgeInsets.only(bottom: 24),
        child: OnboardingArtLessNoise(),
      ),
      OnboardingSlideKind.onePriority => const Padding(
        padding: EdgeInsets.only(bottom: 24),
        child: OnboardingArtOnePriority(),
      ),
      OnboardingSlideKind.celebrate => const Padding(
        padding: EdgeInsets.only(bottom: 24),
        child: OnboardingArtCelebrate(),
      ),
    };
  }
}
