import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

/// 48x28 black pill switch with a white thumb (Figma "Switch").
class PillSwitch extends StatelessWidget {
  const PillSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    required this.semanticsLabel,
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final String semanticsLabel;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Semantics(
      toggled: value,
      label: semanticsLabel,
      onTap: () => onChanged(!value),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => onChanged(!value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: 48,
          height: 28,
          padding: const EdgeInsets.all(2),
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          decoration: BoxDecoration(
            color: value ? colors.inverse : colors.surfaceStronger,
            borderRadius: BorderRadius.circular(9999),
          ),
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: value ? colors.onInverse : colors.surface,
              shape: BoxShape.circle,
              boxShadow: const [
                BoxShadow(
                  color: Color(0x0D000000),
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
