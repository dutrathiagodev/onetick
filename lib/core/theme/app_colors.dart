import 'package:flutter/material.dart';

/// Semantic color tokens extracted from the OneTick Figma file.
///
/// Light values are the Figma values; dark values are derived (the Figma file
/// has no dark frames) and keep the same semantic roles.
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.background,
    required this.surface,
    required this.surfaceMuted,
    required this.surfaceContainer,
    required this.surfaceStrong,
    required this.surfaceStronger,
    required this.text,
    required this.textMuted,
    required this.textFaint,
    required this.placeholder,
    required this.outline,
    required this.border,
    required this.brand,
    required this.brandStrong,
    required this.onBrand,
    required this.mint,
    required this.mintBright,
    required this.onMint,
    required this.danger,
    required this.dangerContainer,
    required this.inverse,
    required this.onInverse,
  });

  final Color background;
  final Color surface;
  final Color surfaceMuted;
  final Color surfaceContainer;
  final Color surfaceStrong;
  final Color surfaceStronger;
  final Color text;
  final Color textMuted;
  final Color textFaint;
  final Color placeholder;
  final Color outline;
  final Color border;
  final Color brand;
  final Color brandStrong;
  final Color onBrand;
  final Color mint;
  final Color mintBright;
  final Color onMint;
  final Color danger;
  final Color dangerContainer;
  final Color inverse;
  final Color onInverse;

  static const light = AppColors(
    background: Color(0xFFF8F9FB),
    surface: Color(0xFFFFFFFF),
    surfaceMuted: Color(0xFFF3F4F6),
    surfaceContainer: Color(0xFFEDEEF0),
    surfaceStrong: Color(0xFFE7E8EA),
    surfaceStronger: Color(0xFFE1E2E4),
    text: Color(0xFF191C1E),
    textMuted: Color(0xFF46464B),
    textFaint: Color(0xFF76777B),
    placeholder: Color(0xFF9CA3AF),
    outline: Color(0xFFC7C6CB),
    border: Color(0xFFE5E7EB),
    brand: Color(0xFF006C49),
    brandStrong: Color(0xFF00714D),
    onBrand: Color(0xFFFFFFFF),
    mint: Color(0xFF6CF8BB),
    mintBright: Color(0xFF6FFBBE),
    onMint: Color(0xFF005236),
    danger: Color(0xFFBA1A1A),
    dangerContainer: Color(0xFFFFDAD6),
    inverse: Color(0xFF000000),
    onInverse: Color(0xFFFFFFFF),
  );

  static const dark = AppColors(
    background: Color(0xFF111315),
    surface: Color(0xFF1B1D1F),
    surfaceMuted: Color(0xFF242628),
    surfaceContainer: Color(0xFF2B2D30),
    surfaceStrong: Color(0xFF323437),
    surfaceStronger: Color(0xFF3A3C40),
    text: Color(0xFFE8EAEC),
    textMuted: Color(0xFFB0B1B6),
    textFaint: Color(0xFF8E8F93),
    placeholder: Color(0xFF7C8088),
    outline: Color(0xFF4A4B50),
    border: Color(0xFF34363A),
    brand: Color(0xFF4EDEA3),
    brandStrong: Color(0xFF4EDEA3),
    onBrand: Color(0xFF00281A),
    mint: Color(0xFF0F4D38),
    mintBright: Color(0xFF145C43),
    onMint: Color(0xFF6CF8BB),
    danger: Color(0xFFFFB4AB),
    dangerContainer: Color(0xFF4A1F1B),
    inverse: Color(0xFFFFFFFF),
    onInverse: Color(0xFF000000),
  );

  @override
  AppColors copyWith() => this;

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    Color l(Color a, Color b) => Color.lerp(a, b, t)!;
    return AppColors(
      background: l(background, other.background),
      surface: l(surface, other.surface),
      surfaceMuted: l(surfaceMuted, other.surfaceMuted),
      surfaceContainer: l(surfaceContainer, other.surfaceContainer),
      surfaceStrong: l(surfaceStrong, other.surfaceStrong),
      surfaceStronger: l(surfaceStronger, other.surfaceStronger),
      text: l(text, other.text),
      textMuted: l(textMuted, other.textMuted),
      textFaint: l(textFaint, other.textFaint),
      placeholder: l(placeholder, other.placeholder),
      outline: l(outline, other.outline),
      border: l(border, other.border),
      brand: l(brand, other.brand),
      brandStrong: l(brandStrong, other.brandStrong),
      onBrand: l(onBrand, other.onBrand),
      mint: l(mint, other.mint),
      mintBright: l(mintBright, other.mintBright),
      onMint: l(onMint, other.onMint),
      danger: l(danger, other.danger),
      dangerContainer: l(dangerContainer, other.dangerContainer),
      inverse: l(inverse, other.inverse),
      onInverse: l(onInverse, other.onInverse),
    );
  }
}

extension AppColorsContext on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
}
