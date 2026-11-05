import 'package:flutter/material.dart';

import 'onetick_mark.dart';

import '../app_assets.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import 'app_icon.dart';

/// Round user button shown at the right of every header: the profile picture
/// when there is one, otherwise the black user icon.
class UserAvatarButton extends StatelessWidget {
  const UserAvatarButton({super.key, required this.onPressed, this.photoUrl});

  final VoidCallback onPressed;
  final String? photoUrl;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final icon = AppIcon(AppAssets.userWhite, tint: colors.onInverse);
    final url = photoUrl;
    return Semantics(
      button: true,
      label: 'Conta',
      child: GestureDetector(
        onTap: onPressed,
        behavior: HitTestBehavior.opaque,
        child: SizedBox(
          width: 48,
          height: 48,
          child: Center(
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: colors.inverse,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              clipBehavior: Clip.antiAlias,
              child: url == null
                  ? icon
                  : Image.network(
                      url,
                      width: 32,
                      height: 32,
                      fit: BoxFit.cover,
                      // Offline or broken link: keep the default icon.
                      errorBuilder: (_, _, _) => icon,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Frosted header used on the Today / History / Settings tabs:
/// logo + "OneTick" + current section, avatar on the right.
class AppTopBar extends StatelessWidget {
  const AppTopBar({
    super.key,
    required this.section,
    required this.onAvatarPressed,
    this.photoUrl,
  });

  final String section;
  final VoidCallback onAvatarPressed;
  final String? photoUrl;

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
            padding: const EdgeInsets.only(left: 20, right: 12),
            child: Row(
              children: [
                const OneTickMark(size: 32),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'OneTick',
                        style: AppTextStyles.subtitle.copyWith(
                          color: colors.text,
                          height: 1,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: colors.brand,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              section,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.caption.copyWith(
                                color: colors.textMuted,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                UserAvatarButton(
                  onPressed: onAvatarPressed,
                  photoUrl: photoUrl,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
