import 'package:flutter/material.dart';

import '../../../../presenter/onboarding/onboarding_state.dart';
import '../../widgets/onboarding_footer.dart';
import '../../widgets/onboarding_header.dart';
import '../../widgets/onboarding_slide_view.dart';

/// Success scenario: carousel with header (counter + skip) and footer (dots,
/// CTA, login link). Owns only the [PageController]; state lives in the cubit.
class OnboardingView extends StatefulWidget {
  const OnboardingView({
    super.key,
    required this.state,
    required this.onPageChanged,
    required this.onSkip,
    required this.onFinish,
    required this.onLogin,
  });

  final OnboardingSuccess state;
  final ValueChanged<int> onPageChanged;
  final VoidCallback onSkip;
  final VoidCallback onFinish;
  final VoidCallback onLogin;

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _next() {
    if (widget.state.isLast) {
      widget.onFinish();
      return;
    }
    _controller.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.state;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            OnboardingHeader(
              current: state.index + 1,
              total: state.slides.length,
              onSkip: widget.onSkip,
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: state.slides.length,
                onPageChanged: widget.onPageChanged,
                itemBuilder: (_, i) =>
                    OnboardingSlideView(slide: state.slides[i]),
              ),
            ),
            OnboardingFooter(
              index: state.index,
              count: state.slides.length,
              isLast: state.isLast,
              onNext: _next,
              onLogin: widget.onLogin,
            ),
          ],
        ),
      ),
    );
  }
}
