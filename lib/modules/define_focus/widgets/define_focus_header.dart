import 'package:flutter/material.dart';

import '../../../core/widgets/onetick_mark.dart';

import '../../../core/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_icon.dart';
import '../../../core/widgets/app_top_bar.dart';

/// Header of the define-focus screen: back, logo, "Editar Foco", avatar.
class DefineFocusHeader extends StatelessWidget implements PreferredSizeWidget {
  const DefineFocusHeader({
    super.key,
    required this.onBack,
    required this.onAvatar,
  });

  final VoidCallback onBack;
  final VoidCallback onAvatar;

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      decoration: BoxDecoration(
        color: colors.background.withValues(alpha: 0.85),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 8,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 64,
          child: Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Row(
              children: [
                Semantics(
                  button: true,
                  label: 'Voltar',
                  child: InkResponse(
                    key: const Key('define_focus_back'),
                    onTap: onBack,
                    radius: 24,
                    child: SizedBox(
                      width: 44,
                      height: 44,
                      child: Center(
                        child: AppIcon(AppAssets.backArrow, tint: colors.text),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                const OneTickMark(size: 28),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Editar Foco',
                    style: AppTextStyles.subtitle.copyWith(color: colors.text),
                  ),
                ),
                UserAvatarButton(onPressed: onAvatar),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
