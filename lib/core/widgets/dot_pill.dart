import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// Small rounded badge with a leading dot (e.g. "1 DE 3", "ONETICK APP").
class DotPill extends StatelessWidget {
  const DotPill({
    super.key,
    required this.label,
    required this.background,
    required this.textStyle,
    this.dotColor,
    this.dotSize = 6,
    this.gap = 6,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
  });

  final String label;
  final Color background;
  final TextStyle textStyle;
  final Color? dotColor;
  final double dotSize;
  final double gap;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: ShapeDecoration(
        color: background,
        shape: const StadiumBorder(),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: dotSize,
            height: dotSize,
            decoration: BoxDecoration(
              color: dotColor ?? context.colors.brand,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: gap),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textStyle,
            ),
          ),
        ],
      ),
    );
  }
}

/// Convenience for the most common caption style used inside pills.
TextStyle pillCaption(BuildContext context, {Color? color}) =>
    AppTextStyles.caption.copyWith(color: color ?? context.colors.textMuted);
