import 'package:flutter/material.dart';

import '../app_assets.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import 'app_icon.dart';

class AppBottomNavItem {
  const AppBottomNavItem({
    required this.label,
    required this.activeIcon,
    required this.inactiveIcon,
  });

  final String label;
  final String activeIcon;
  final String inactiveIcon;
}

const List<AppBottomNavItem> kHomeNavItems = [
  AppBottomNavItem(
    label: 'Hoje',
    activeIcon: AppAssets.navTodayActive,
    inactiveIcon: AppAssets.navTodayInactive,
  ),
  AppBottomNavItem(
    label: 'Histórico',
    activeIcon: AppAssets.navHistoryActive,
    inactiveIcon: AppAssets.navHistoryInactive,
  ),
  AppBottomNavItem(
    label: 'Configurações',
    activeIcon: AppAssets.navSettingsActive,
    inactiveIcon: AppAssets.navSettingsInactive,
  ),
];

/// Bottom navigation with the Figma look (icon + 11px label, green when active).
class AppBottomNav extends StatelessWidget {
  const AppBottomNav({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onSelected,
  });

  final List<AppBottomNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final media = MediaQuery.of(context);
    return MediaQuery(
      data: media.copyWith(
        textScaler: media.textScaler.clamp(maxScaleFactor: 1.2),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: colors.background.withValues(alpha: 0.9),
          boxShadow: const [
            BoxShadow(
              color: Color(0x08000000),
              blurRadius: 12,
              offset: Offset(0, -1),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 64,
            child: Row(
              children: [
                for (var i = 0; i < items.length; i++)
                  Expanded(
                    child: _NavButton(
                      item: items[i],
                      selected: i == currentIndex,
                      onTap: () => onSelected(i),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  const _NavButton({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final AppBottomNavItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Semantics(
      button: true,
      selected: selected,
      label: item.label,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppIcon(
              selected ? item.activeIcon : item.inactiveIcon,
              tint: selected ? colors.brand : colors.textMuted,
            ),
            const SizedBox(height: 2),
            Text(
              item.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.caption.copyWith(
                color: selected ? colors.brand : colors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
