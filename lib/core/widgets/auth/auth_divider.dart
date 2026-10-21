import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Horizontal rule with a centered label ("OU CONTINUAR COM").
class AuthDivider extends StatelessWidget {
  const AuthDivider({
    super.key,
    required this.label,
    required this.labelStyle,
    required this.lineColor,
  });

  final String label;
  final TextStyle labelStyle;
  final Color lineColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Container(height: 1, color: lineColor)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            label,
            style: labelStyle.copyWith(
              color: labelStyle.color ?? context.colors.textMuted,
            ),
          ),
        ),
        Expanded(child: Container(height: 1, color: lineColor)),
      ],
    );
  }
}
