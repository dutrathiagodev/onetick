import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/onetick_mark.dart';
import '../../../core/widgets/dot_pill.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: Color.alphaBlend(
              colors.mintBright.withValues(alpha: 0.3),
              colors.mint.withValues(alpha: 0.4),
            ),
            shape: BoxShape.circle,
            boxShadow: const [
              BoxShadow(
                color: Color(0x0D000000),
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: const OneTickMark(size: 34),
        ),
        const SizedBox(height: 8),
        DotPill(
          label: 'ONETICK APP',
          background: colors.surfaceMuted,
          textStyle: AppTextStyles.caption.copyWith(color: colors.brand),
        ),
        const SizedBox(height: 4),
        Text(
          'Entrar',
          style: AppTextStyles.headline.copyWith(color: colors.text),
        ),
        const SizedBox(height: 3),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 280),
          child: Text(
            'Acesse seu foco diário. Simples e sem distrações.',
            textAlign: TextAlign.center,
            style: AppTextStyles.body.copyWith(
              color: colors.textMuted,
              height: 20.63 / 15,
            ),
          ),
        ),
      ],
    );
  }
}
