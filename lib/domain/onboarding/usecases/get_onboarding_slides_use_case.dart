import '../entities/onboarding_slide_entity.dart';
import '../repositories/onboarding_repository.dart';

class GetOnboardingSlidesUseCase {
  const GetOnboardingSlidesUseCase(this._repository);

  final OnboardingRepository _repository;

  Future<List<OnboardingSlide>> call() => _repository.getSlides();
}
