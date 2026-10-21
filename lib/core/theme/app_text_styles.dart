import 'package:flutter/material.dart';

/// Typography tokens from Figma (Inter). Colors are applied by the caller via
/// [TextStyle.copyWith] so the styles stay theme agnostic.
abstract final class AppTextStyles {
  static TextStyle _inter(
    double size,
    FontWeight weight,
    double lineHeight, {
    double letterSpacing = 0,
  }) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: size,
      fontWeight: weight,
      height: lineHeight / size,
      letterSpacing: letterSpacing,
    );
  }

  static final display = _inter(
    30,
    FontWeight.w700,
    37.5,
    letterSpacing: -0.75,
  );
  static final headline = _inter(28, FontWeight.w600, 36, letterSpacing: -0.7);
  static final title = _inter(22, FontWeight.w500, 28, letterSpacing: -0.33);
  static final subtitle = _inter(18, FontWeight.w500, 24, letterSpacing: -0.18);
  static final bodyLarge = _inter(
    17,
    FontWeight.w400,
    24,
    letterSpacing: -0.17,
  );
  static final body = _inter(15, FontWeight.w400, 22, letterSpacing: -0.075);
  static final bodyMedium = _inter(
    15,
    FontWeight.w500,
    22,
    letterSpacing: -0.075,
  );
  static final label = _inter(13, FontWeight.w400, 18);
  static final labelMedium = _inter(
    13,
    FontWeight.w500,
    16,
    letterSpacing: 0.13,
  );
  static final labelSemi = _inter(13, FontWeight.w600, 16, letterSpacing: 0.13);
  static final caption = _inter(11, FontWeight.w600, 14, letterSpacing: 0.33);
  static final captionMedium = _inter(
    11,
    FontWeight.w500,
    14,
    letterSpacing: 0.33,
  );
  static final overline = _inter(11, FontWeight.w600, 14, letterSpacing: 0.55);
}
