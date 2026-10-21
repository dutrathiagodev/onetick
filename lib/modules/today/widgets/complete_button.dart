import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_icon.dart';

/// 144px circular "TOCAR PARA CONCLUIR" button with the soft green halo.
class CompleteButton extends StatelessWidget {
  const CompleteButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  final bool isLoading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return SizedBox(
      width: 176,
      height: 176,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 176,
            height: 176,
            decoration: BoxDecoration(
              color: colors.brand.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
          ),
          Semantics(
            button: true,
            label: 'Concluir foco de hoje',
            child: Container(
              decoration: BoxDecoration(
                color: colors.surfaceMuted,
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x1A000000),
                    blurRadius: 6,
                    offset: Offset(0, 4),
                    spreadRadius: -1,
                  ),
                  BoxShadow(
                    color: Color(0x1A000000),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                    spreadRadius: -2,
                  ),
                ],
              ),
              child: Material(
                type: MaterialType.transparency,
                shape: const CircleBorder(),
                child: InkWell(
                  key: const Key('today_complete_button'),
                  customBorder: const CircleBorder(),
                  onTap: isLoading
                      ? null
                      : () {
                          HapticFeedback.mediumImpact();
                          onPressed();
                        },
                  child: SizedBox(
                    width: 144,
                    height: 144,
                    child: Center(
                      child: isLoading
                          ? SizedBox(
                              width: 28,
                              height: 28,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: colors.brand,
                              ),
                            )
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: Center(
                                    child: AppIcon(
                                      AppAssets.tap,
                                      tint: colors.text,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'TOCAR PARA\nCONCLUIR',
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.captionMedium.copyWith(
                                    color: colors.textMuted,
                                    letterSpacing: 0.275,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
