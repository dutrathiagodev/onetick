import 'package:flutter/material.dart';

import '../app_assets.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import 'app_icon.dart';
import 'onetick_mark.dart';

/// Frosted 64px bar shared by every screen header (tabs, Definir Foco,
/// Privacidade/Termos).
class HeaderBar extends StatelessWidget {
  const HeaderBar({super.key, required this.padding, required this.child});

  final EdgeInsets padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.background.withValues(alpha: 0.85),
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
          child: Padding(padding: padding, child: child),
        ),
      ),
    );
  }
}

/// Header of pushed screens: back, logo, title and an optional trailing
/// widget (the avatar on Definir Foco).
class BackTitleBar extends StatelessWidget {
  const BackTitleBar({
    super.key,
    required this.title,
    required this.onBack,
    this.backKey,
    this.trailing,
  });

  final String title;
  final VoidCallback onBack;
  final Key? backKey;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return HeaderBar(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          AppBackButton(key: backKey, onPressed: onBack),
          const SizedBox(width: 8),
          const OneTickMark(size: 28),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.subtitle.copyWith(color: colors.text),
            ),
          ),
          ?trailing,
        ],
      ),
    );
  }
}

/// 44px round "Voltar" button with the back arrow.
class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Voltar',
      child: InkResponse(
        onTap: onPressed,
        radius: 24,
        child: SizedBox(
          width: 44,
          height: 44,
          child: Center(
            child: AppIcon(AppAssets.backArrow, tint: context.colors.text),
          ),
        ),
      ),
    );
  }
}
