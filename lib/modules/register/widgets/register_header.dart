import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/onetick_mark.dart';
import '../../../core/widgets/dot_pill.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: colors.mint.withValues(alpha: 0.4),
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
          child: const OneTickMark(size: 30),
        ),
        const SizedBox(height: 14),
        DotPill(
          label: 'ONETICK APP',
          background: colors.surfaceContainer,
          textStyle: AppTextStyles.caption.copyWith(
            fontSize: 12,
            height: 16 / 12,
            letterSpacing: 0.3,
            color: colors.brand,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Criar conta',
          style: AppTextStyles.display.copyWith(color: colors.text),
        ),
        const SizedBox(height: 6),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 280),
          child: Text(
            'Comece seu foco diário. Simples e sem distrações.',
            textAlign: TextAlign.center,
            style: AppTextStyles.label.copyWith(
              fontSize: 14,
              height: 19.25 / 14,
              color: colors.textMuted,
            ),
          ),
        ),
      ],
    );
  }
}
