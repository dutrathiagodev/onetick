import '../../../domain/onboarding/entities/onboarding_slide.dart';

class OnboardingSlideModel {
  const OnboardingSlideModel({
    required this.kind,
    required this.title,
    required this.description,
  });

  final String kind;
  final String title;
  final String description;

  OnboardingSlide toEntity() {
    return OnboardingSlide(
      kind: OnboardingSlideKind.values.firstWhere((k) => k.name == kind),
      title: title,
      description: description,
    );
  }
}
