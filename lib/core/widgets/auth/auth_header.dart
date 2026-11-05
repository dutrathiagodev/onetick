import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../dot_pill.dart';
import '../onetick_mark.dart';

/// Logo badge + "ONETICK APP" pill + title + subtitle on Login and Sign-up.
class AuthHeader extends StatelessWidget {
  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.emphasized = false,
  });

  final String title;
  final String subtitle;

  /// Login frame: bigger brighter badge, tighter spacing and a smaller title
  /// than the sign-up frame (same convention as `AuthFooter`).
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final badgeSize = emphasized ? 64.0 : 56.0;
    return Column(
      children: [
        Container(
          width: badgeSize,
          height: badgeSize,
          decoration: BoxDecoration(
            color: emphasized
                ? Color.alphaBlend(
                    colors.mintBright.withValues(alpha: 0.3),
                    colors.mint.withValues(alpha: 0.4),
                  )
                : colors.mint.withValues(alpha: 0.4),
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
          child: OneTickMark(size: emphasized ? 34 : 30),
        ),
        SizedBox(height: emphasized ? 8 : 14),
        DotPill(
          label: 'ONETICK APP',
          background: emphasized
              ? colors.surfaceMuted
              : colors.surfaceContainer,
          textStyle: emphasized
              ? AppTextStyles.caption.copyWith(color: colors.brand)
              : AppTextStyles.caption.copyWith(
                  fontSize: 12,
                  height: 16 / 12,
                  letterSpacing: 0.3,
                  color: colors.brand,
                ),
        ),
        SizedBox(height: emphasized ? 4 : 12),
        Text(
          title,
          style: (emphasized ? AppTextStyles.headline : AppTextStyles.display)
              .copyWith(color: colors.text),
        ),
        SizedBox(height: emphasized ? 3 : 6),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 280),
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: emphasized
                ? AppTextStyles.body.copyWith(
                    color: colors.textMuted,
                    height: 20.63 / 15,
                  )
                : AppTextStyles.label.copyWith(
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
