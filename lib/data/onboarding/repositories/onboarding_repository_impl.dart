import '../../../domain/onboarding/entities/onboarding_slide.dart';
import '../../../domain/onboarding/repositories/onboarding_repository.dart';
import '../../../infra/adapters/onboarding/onboarding_local_adapter.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  const OnboardingRepositoryImpl(this._adapter);

  final OnboardingLocalAdapter _adapter;

  @override
  Future<List<OnboardingSlide>> getSlides() async =>
      (await _adapter.slides()).map((s) => s.toEntity()).toList();
}
