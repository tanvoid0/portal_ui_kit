import 'package:flutter/material.dart';

/// ThemeConfig is the base class for all theme configurations.
/// It defines the structure for colors, typography, and other theme properties.
class ThemeConfig {
  final String name;
  final ColorScheme colorScheme;
  final TextTheme textTheme;
  final double borderRadius;
  final double borderWidth;
  final bool pixelated;
  final BoxShadow? defaultShadow;

  const ThemeConfig({
    required this.name,
    required this.colorScheme,
    required this.textTheme,
    this.borderRadius = 4.0,
    this.borderWidth = 2.0,
    this.pixelated = false,
    this.defaultShadow,
  });

  /// Convert the theme config to a Flutter ThemeData
  ThemeData toThemeData() {
    return ThemeData(
      colorScheme: colorScheme,
      textTheme: textTheme,
      useMaterial3: true,
      scaffoldBackgroundColor: colorScheme.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      cardTheme: CardThemeData(
        color: colorScheme.surface,
        elevation: defaultShadow != null ? 4.0 : 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: BorderSide(
            color: colorScheme.outline,
            width: borderWidth,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(
              color: colorScheme.outline,
              width: borderWidth,
            ),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: colorScheme.outline,
            width: borderWidth,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: colorScheme.outline,
            width: borderWidth,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: colorScheme.primary,
            width: borderWidth,
          ),
        ),
      ),
    );
  }

  /// Create a copy of this theme config with the given fields replaced
  ThemeConfig copyWith({
    String? name,
    ColorScheme? colorScheme,
    TextTheme? textTheme,
    double? borderRadius,
    double? borderWidth,
    bool? pixelated,
    BoxShadow? defaultShadow,
  }) {
    return ThemeConfig(
      name: name ?? this.name,
      colorScheme: colorScheme ?? this.colorScheme,
      textTheme: textTheme ?? this.textTheme,
      borderRadius: borderRadius ?? this.borderRadius,
      borderWidth: borderWidth ?? this.borderWidth,
      pixelated: pixelated ?? this.pixelated,
      defaultShadow: defaultShadow ?? this.defaultShadow,
    );
  }
}