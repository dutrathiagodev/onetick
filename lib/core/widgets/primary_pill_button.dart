import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import 'app_icon.dart';

/// Black pill CTA used across onboarding, auth and focus screens.
class PrimaryPillButton extends StatelessWidget {
  const PrimaryPillButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.iconAsset,
    this.height = 52,
    this.labelStyle,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final String? iconAsset;
  final double height;
  final TextStyle? labelStyle;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final enabled = onPressed != null && !isLoading;
    final style = (labelStyle ?? AppTextStyles.labelMedium).copyWith(
      color: colors.onInverse,
    );

    return Semantics(
      button: true,
      enabled: enabled,
      label: label,
      child: Opacity(
        opacity: onPressed == null && !isLoading ? 0.4 : 1,
        child: Material(
          color: colors.inverse,
          shape: const StadiumBorder(),
          elevation: 1,
          shadowColor: const Color(0x0D000000),
          child: InkWell(
            customBorder: const StadiumBorder(),
            onTap: enabled ? onPressed : null,
            child: SizedBox(
              height: height,
              width: double.infinity,
              child: Center(
                child: isLoading
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: colors.onInverse,
                        ),
                      )
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(label, style: style),
                          if (iconAsset != null) ...[
                            const SizedBox(width: 8),
                            AppIcon(iconAsset!, tint: colors.onInverse),
                          ],
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
