import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_icon.dart';

/// Row with a 32px icon tile, title/subtitle and a trailing widget/chevron.
class SettingsRow extends StatelessWidget {
  const SettingsRow({
    super.key,
    required this.iconAsset,
    required this.title,
    this.subtitle,
    this.trailing,
    this.chevronAsset,
    this.iconBackground,
    this.titleColor,
    this.onTap,
  });

  final String iconAsset;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final String? chevronAsset;
  final Color? iconBackground;
  final Color? titleColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isDanger = titleColor != null;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: iconBackground ?? colors.surfaceMuted,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: AppIcon(iconAsset, tint: isDanger ? null : colors.text),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: titleColor ?? colors.text,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: AppTextStyles.label.copyWith(
                        color: colors.textMuted,
                      ),
                    ),
                ],
              ),
            ),
            if (trailing != null) ...[const SizedBox(width: 12), trailing!],
            if (chevronAsset != null) ...[
              const SizedBox(width: 12),
              AppIcon(chevronAsset!, tint: isDanger ? null : colors.text),
            ],
          ],
        ),
      ),
    );
  }
}
