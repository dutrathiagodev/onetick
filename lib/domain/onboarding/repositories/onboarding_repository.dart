import '../entities/onboarding_slide_entity.dart';

abstract interface class OnboardingRepository {
  Future<List<OnboardingSlide>> getSlides();
}
