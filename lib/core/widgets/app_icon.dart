import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Renders an exported Figma SVG at its intrinsic size.
///
/// [tint] recolors monochrome icons (used to adapt "ink" icons to dark mode);
/// leave it null for multicolor assets such as the Google logo.
class AppIcon extends StatelessWidget {
  const AppIcon(this.asset, {super.key, this.tint});

  final String asset;
  final Color? tint;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      asset,
      colorFilter: tint == null
          ? null
          : ColorFilter.mode(tint!, BlendMode.srcIn),
    );
  }
}
