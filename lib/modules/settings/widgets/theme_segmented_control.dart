import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../domain/settings/entities/app_settings.dart';

/// "Claro | Escuro" pill segmented control.
class ThemeSegmentedControl extends StatelessWidget {
  const ThemeSegmentedControl({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final AppThemePreference value;
  final ValueChanged<AppThemePreference> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: colors.surfaceMuted,
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _Segment(
            key: const Key('theme_light'),
            label: 'Claro',
            selected: value == AppThemePreference.light,
            onTap: () => onChanged(AppThemePreference.light),
          ),
          const SizedBox(width: 4),
          _Segment(
            key: const Key('theme_dark'),
            label: 'Escuro',
            selected: value == AppThemePreference.dark,
            onTap: () => onChanged(AppThemePreference.dark),
          ),
        ],
      ),
    );
  }
}

class _Segment extends StatelessWidget {
  const _Segment({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Semantics(
      button: true,
      selected: selected,
      label: label,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: selected ? colors.inverse : Colors.transparent,
            borderRadius: BorderRadius.circular(9999),
            boxShadow: selected
                ? const [
                    BoxShadow(
                      color: Color(0x0D000000),
                      blurRadius: 1,
                      offset: Offset(0, 1),
                    ),
                  ]
                : null,
          ),
          child: Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: selected ? colors.onInverse : colors.textMuted,
            ),
          ),
        ),
      ),
    );
  }
}
