import '../entities/onboarding_slide.dart';

abstract interface class OnboardingRepository {
  Future<List<OnboardingSlide>> getSlides();
}
