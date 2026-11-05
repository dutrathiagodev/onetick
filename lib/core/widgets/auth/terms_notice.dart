import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

/// "Ao criar sua conta, você concorda com os Termos de Uso e a Política de
/// Privacidade", shown next to the sign-up actions so the terms are seen
/// before the account exists. Both documents open from the links.
class TermsNotice extends StatefulWidget {
  const TermsNotice({
    super.key,
    this.lead =
        'Ao criar sua conta ou continuar com o Google, você concorda com os ',
  });

  /// Text before the links; Login only creates accounts through Google.
  final String lead;

  @override
  State<TermsNotice> createState() => _TermsNoticeState();
}

class _TermsNoticeState extends State<TermsNotice> {
  late final TapGestureRecognizer _terms = TapGestureRecognizer()
    ..onTap = () => Navigator.of(context).pushNamed(AppRoutes.terms);
  late final TapGestureRecognizer _privacy = TapGestureRecognizer()
    ..onTap = () => Navigator.of(context).pushNamed(AppRoutes.privacy);

  @override
  void dispose() {
    _terms.dispose();
    _privacy.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final base = AppTextStyles.label.copyWith(
      fontSize: 11.5,
      height: 17.25 / 11.5,
      color: colors.textFaint,
    );
    final link = base.copyWith(
      color: colors.text,
      fontWeight: FontWeight.w600,
      decoration: TextDecoration.underline,
      decorationColor: colors.outline,
    );
    return Text.rich(
      key: const Key('terms_notice'),
      TextSpan(
        style: base,
        children: [
          TextSpan(text: widget.lead),
          // Non-breaking spaces keep each link on a single line.
          TextSpan(
            text: 'Termos de Uso',
            style: link,
            recognizer: _terms,
          ),
          const TextSpan(text: ' e a '),
          TextSpan(
            text: 'Política de Privacidade',
            style: link,
            recognizer: _privacy,
          ),
          const TextSpan(text: '.'),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
