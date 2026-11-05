import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

/// "Sem anúncios. Sem spam." tagline + Privacidade • Termos • v1.0.
class AuthFooter extends StatelessWidget {
  const AuthFooter({super.key, this.emphasized = false});

  /// Login frame uses semibold 11px; sign-up uses regular 11.5/11px.
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final tagline = emphasized
        ? AppTextStyles.caption.copyWith(color: colors.textMuted)
        : AppTextStyles.label.copyWith(
            fontSize: 11.5,
            height: 17.25 / 11.5,
            color: colors.textFaint,
          );
    final links = emphasized
        ? AppTextStyles.caption.copyWith(color: colors.textFaint)
        : AppTextStyles.label.copyWith(
            fontSize: 11,
            height: 16.5 / 11,
            color: colors.placeholder,
          );
    final dot = emphasized ? const Color(0xFF4EDEA3) : colors.brand;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(color: dot, shape: BoxShape.circle),
            ),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                'Sem anúncios. Sem spam. Feito para ser básico.',
                style: tagline,
              ),
            ),
          ],
        ),
        // The links' own touch area provides the gap below the tagline.
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 8,
          children: [
            _FooterLink(
              key: const Key('footer_privacy'),
              label: 'Privacidade',
              style: links,
              route: AppRoutes.privacy,
            ),
            Text('•', style: links),
            _FooterLink(
              key: const Key('footer_terms'),
              label: 'Termos',
              style: links,
              route: AppRoutes.terms,
            ),
            Text('•', style: links),
            Text('v1.0', style: links),
          ],
        ),
      ],
    );
  }
}

/// Footer text link with a taller touch target than the 11px text, kept
/// at 36px so the footer stays as compact as in the design.
class _FooterLink extends StatelessWidget {
  const _FooterLink({
    super.key,
    required this.label,
    required this.style,
    required this.route,
  });

  final String label;
  final TextStyle style;
  final String route;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      link: true,
      label: label,
      excludeSemantics: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pushNamed(route),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 36),
          child: Center(
            widthFactor: 1,
            // Plain text, as in the design; the area around it is tappable.
            child: Text(label, style: style),
          ),
        ),
      ),
    );
  }
}
