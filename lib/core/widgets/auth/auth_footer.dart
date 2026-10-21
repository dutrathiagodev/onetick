import 'package:flutter/material.dart';

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
        SizedBox(height: emphasized ? 8 : 4),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 8,
          children: [
            Text('Privacidade', style: links),
            Text('•', style: links),
            Text('Termos', style: links),
            Text('•', style: links),
            Text('v1.0', style: links),
          ],
        ),
      ],
    );
  }
}
