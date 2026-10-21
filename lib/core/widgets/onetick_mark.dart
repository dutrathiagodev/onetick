import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// OneTick brand mark (ring + tick). Uses the white/mint variant on dark themes.
class OneTickMark extends StatelessWidget {
  const OneTickMark({super.key, required this.size});

  final double size;

  static const lightAsset = 'assets/images/onetick_mark.svg';
  static const darkAsset = 'assets/images/onetick_mark_dark.svg';

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return SvgPicture.asset(
      dark ? darkAsset : lightAsset,
      width: size,
      height: size,
      semanticsLabel: 'OneTick',
    );
  }
}
