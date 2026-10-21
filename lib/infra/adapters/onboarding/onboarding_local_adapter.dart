import '../../../data/onboarding/models/onboarding_slide_model.dart';

/// Static onboarding copy shipped with the app.
class OnboardingLocalAdapter {
  const OnboardingLocalAdapter();

  Future<List<OnboardingSlideModel>> slides() async => const [
    OnboardingSlideModel(
      kind: 'lessNoise',
      title: 'Menos ruído, mais foco',
      description:
          'Esqueça listas intermináveis de 50 tarefas.\n'
          'Escolha apenas 1 compromisso essencial por dia.',
    ),
    OnboardingSlideModel(
      kind: 'onePriority',
      title: 'Apenas uma prioridade',
      description:
          'Defina o que realmente importa antes do dia começar.\n'
          'Sem notificações invasivas ou distrações.',
    ),
    OnboardingSlideModel(
      kind: 'celebrate',
      title: 'Celebre o dia concluído',
      description:
          'Termine o dia com a sensação de dever cumprido. '
          'Sem culpa, sem sobrecarga.',
    ),
  ];
}
