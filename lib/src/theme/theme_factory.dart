import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'theme_config.dart';

enum ThemeModeType { light, dark }
enum FontType { retro, modern, system }
class ThemePair {
  final ThemeConfig light;
  final ThemeConfig dark;

  ThemePair({required this.light, required this.dark});

  List<ThemeConfig> get allThemes => [light, dark];
}


class ThemeFactory {
  // Existing properties...
  final String name;
  final ColorScheme lightColorScheme;
  final ColorScheme darkColorScheme;
  final FontType fontType;
  final double borderRadius;
  final double borderWidth;
  final bool pixelated;
  final BoxShadow? defaultShadow;

  ThemeFactory({
    required this.name,
    required this.lightColorScheme,
    required this.darkColorScheme,
    this.fontType = FontType.system,
    this.borderRadius = 4.0,
    this.borderWidth = 2.0,
    this.pixelated = false,
    this.defaultShadow,
  });

  ThemePair build() {
    final lightTheme = ThemeConfig(
      name: '$name Light',
      colorScheme: lightColorScheme,
      textTheme: _buildTextTheme(lightColorScheme),
      borderRadius: borderRadius,
      borderWidth: borderWidth,
      pixelated: pixelated,
      defaultShadow: defaultShadow,
      mode: ThemeModeType.light,
    );

    final darkTheme = ThemeConfig(
      name: '$name Dark',
      colorScheme: darkColorScheme,
      textTheme: _buildTextTheme(darkColorScheme),
      borderRadius: borderRadius,
      borderWidth: borderWidth,
      pixelated: pixelated,
      defaultShadow: defaultShadow,
      mode: ThemeModeType.dark,
    );

    return ThemePair(light: lightTheme, dark: darkTheme);
  }

  TextTheme _buildTextTheme(ColorScheme scheme) {
    // Same as before
    switch (fontType) {
      case FontType.retro:
        return GoogleFonts.pressStart2pTextTheme().apply(
          bodyColor: scheme.onSurface,
          displayColor: scheme.onSurface,
        );
      case FontType.modern:
        return GoogleFonts.interTextTheme().apply(
          bodyColor: scheme.onSurface,
          displayColor: scheme.onSurface,
        );
      case FontType.system:
      default:
        return Typography.material2021().black.apply(
          bodyColor: scheme.onSurface,
          displayColor: scheme.onSurface,
        );
    }
  }
}
