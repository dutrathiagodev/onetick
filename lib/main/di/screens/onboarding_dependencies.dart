import '../../../data/onboarding/repositories/onboarding_repository_impl.dart';
import '../../../domain/onboarding/repositories/onboarding_repository.dart';
import '../../../domain/onboarding/usecases/get_onboarding_slides_use_case.dart';
import '../../../infra/adapters/onboarding/onboarding_local_adapter.dart';
import '../../../presenter/onboarding/onboarding_cubit.dart';
import '../service_locator.dart';

void setupOnboardingDependencies() {
  if (!getIt.isRegistered<OnboardingLocalAdapter>()) {
    getIt.registerLazySingleton(() => const OnboardingLocalAdapter());
  }
  if (!getIt.isRegistered<OnboardingRepository>()) {
    getIt.registerLazySingleton<OnboardingRepository>(
      () => OnboardingRepositoryImpl(getIt<OnboardingLocalAdapter>()),
    );
  }
  if (!getIt.isRegistered<GetOnboardingSlidesUseCase>()) {
    getIt.registerFactory(
      () => GetOnboardingSlidesUseCase(getIt<OnboardingRepository>()),
    );
  }
  if (!getIt.isRegistered<OnboardingCubit>()) {
    getIt.registerFactory(
      () => OnboardingCubit(getIt<GetOnboardingSlidesUseCase>()),
    );
  }
}
