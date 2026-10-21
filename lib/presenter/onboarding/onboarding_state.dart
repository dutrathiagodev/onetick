import 'package:equatable/equatable.dart';

import '../../domain/onboarding/entities/onboarding_slide.dart';

sealed class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object?> get props => [];
}

class OnboardingLoading extends OnboardingState {
  const OnboardingLoading();
}

class OnboardingEmpty extends OnboardingState {
  const OnboardingEmpty();
}

class OnboardingError extends OnboardingState {
  const OnboardingError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

class OnboardingSuccess extends OnboardingState {
  const OnboardingSuccess({required this.slides, required this.index});

  final List<OnboardingSlide> slides;
  final int index;

  bool get isLast => index == slides.length - 1;

  OnboardingSuccess copyWith({int? index}) =>
      OnboardingSuccess(slides: slides, index: index ?? this.index);

  @override
  List<Object?> get props => [slides, index];
}
