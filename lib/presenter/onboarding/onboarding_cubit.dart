import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/onboarding/usecases/get_onboarding_slides_use_case.dart';
import 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit(this._getSlides) : super(const OnboardingLoading());

  final GetOnboardingSlidesUseCase _getSlides;

  Future<void> load() async {
    emit(const OnboardingLoading());
    try {
      final slides = await _getSlides();
      emit(
        slides.isEmpty
            ? const OnboardingEmpty()
            : OnboardingSuccess(slides: slides, index: 0),
      );
    } catch (_) {
      emit(const OnboardingError('Não foi possível carregar a introdução.'));
    }
  }

  void pageChanged(int index) {
    final current = state;
    if (current is OnboardingSuccess &&
        index >= 0 &&
        index < current.slides.length) {
      emit(current.copyWith(index: index));
    }
  }
}
