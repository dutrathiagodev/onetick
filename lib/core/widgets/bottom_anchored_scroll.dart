import 'package:flutter/material.dart';

/// Scrollable page with a [top] block pinned to the top and a [bottom] block
/// pinned to the bottom when there is spare room. When content is taller than
/// the viewport (small screen, large text, open keyboard) it simply scrolls —
/// it never overflows.
class BottomAnchoredScroll extends StatelessWidget {
  const BottomAnchoredScroll({
    super.key,
    required this.top,
    required this.bottom,
    this.padding = EdgeInsets.zero,
  });

  final List<Widget> top;
  final List<Widget> bottom;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final minHeight = (constraints.maxHeight - padding.vertical).clamp(
          0.0,
          double.infinity,
        );
        return SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: padding,
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: minHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: top,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: bottom,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
