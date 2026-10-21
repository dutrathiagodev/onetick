import 'package:equatable/equatable.dart';

enum OnboardingSlideKind { lessNoise, onePriority, celebrate }

class OnboardingSlide extends Equatable {
  const OnboardingSlide({
    required this.kind,
    required this.title,
    required this.description,
  });

  final OnboardingSlideKind kind;
  final String title;
  final String description;

  @override
  List<Object?> get props => [kind, title, description];
}
