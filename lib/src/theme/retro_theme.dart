import 'package:flutter/material.dart';
import 'theme_config.dart';

/// RetroTheme is a theme configuration inspired by nes.css
/// It provides a pixelated, retro-style UI with bold borders and bright colors
class RetroTheme extends ThemeConfig {
  RetroTheme({
    String name = 'Retro',
    ColorScheme? colorScheme,
    TextTheme? textTheme,
    double borderRadius = 0.0, // Pixel-perfect corners
    double borderWidth = 4.0, // Thick borders
    BoxShadow? defaultShadow,
  }) : super(
          name: name,
          colorScheme: colorScheme ?? _defaultRetroColorScheme,
          textTheme: textTheme ?? _defaultRetroTextTheme,
          borderRadius: borderRadius,
          borderWidth: borderWidth,
          pixelated: true,
          defaultShadow: defaultShadow ?? _defaultRetroShadow,
        );

  /// Dark variant of the retro theme
  factory RetroTheme.dark() {
    return RetroTheme(
      name: 'Retro Dark',
      colorScheme: _darkRetroColorScheme,
      textTheme: _defaultRetroTextTheme,
    );
  }

  /// Create a custom retro theme with specific colors
  factory RetroTheme.custom({
    required String name,
    required Color primaryColor,
    required Color backgroundColor,
    required Color textColor,
    double borderRadius = 0.0,
    double borderWidth = 4.0,
  }) {
    final ColorScheme customColorScheme = ColorScheme(
      primary: primaryColor,
      onPrimary: Colors.white,
      secondary: primaryColor.withOpacity(0.8),
      onSecondary: Colors.white,
      surface: backgroundColor,
      onSurface: textColor,
      background: backgroundColor,
      onBackground: textColor,
      error: Colors.red.shade800,
      onError: Colors.white,
      brightness: ThemeData.estimateBrightnessForColor(backgroundColor),
      outline: textColor,
    );

    return RetroTheme(
      name: name,
      colorScheme: customColorScheme,
      borderRadius: borderRadius,
      borderWidth: borderWidth,
    );
  }

  @override
  ThemeData toThemeData() {
    final baseTheme = super.toThemeData();
    
    // Add retro-specific theme customizations
    return baseTheme.copyWith(
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(
              color: colorScheme.outline,
              width: borderWidth,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),
      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: BorderSide(
            color: colorScheme.outline,
            width: borderWidth,
          ),
        ),
        backgroundColor: colorScheme.surface,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: colorScheme.surface,
        contentTextStyle: TextStyle(color: colorScheme.onSurface),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: BorderSide(
            color: colorScheme.outline,
            width: borderWidth,
          ),
        ),
      ),
    );
  }

  @override
  RetroTheme copyWith({
    String? name,
    ColorScheme? colorScheme,
    TextTheme? textTheme,
    double? borderRadius,
    double? borderWidth,
    bool? pixelated,
    BoxShadow? defaultShadow,
  }) {
    return RetroTheme(
      name: name ?? this.name,
      colorScheme: colorScheme ?? this.colorScheme,
      textTheme: textTheme ?? this.textTheme,
      borderRadius: borderRadius ?? this.borderRadius,
      borderWidth: borderWidth ?? this.borderWidth,
      defaultShadow: defaultShadow ?? this.defaultShadow,
    );
  }

  // Default retro color scheme (light)
  static final ColorScheme _defaultRetroColorScheme = ColorScheme(
    primary: const Color(0xFF209CEE),
    onPrimary: Colors.white,
    secondary: const Color(0xFF92CC41),
    onSecondary: Colors.white,
    surface: Colors.white,
    onSurface: const Color(0xFF212529),
    background: const Color(0xFFF8F8F8),
    onBackground: const Color(0xFF212529),
    error: const Color(0xFFE76E55),
    onError: Colors.white,
    brightness: Brightness.light,
    outline: const Color(0xFF212529),
  );

  // Dark retro color scheme
  static final ColorScheme _darkRetroColorScheme = ColorScheme(
    primary: const Color(0xFF209CEE),
    onPrimary: Colors.white,
    secondary: const Color(0xFF92CC41),
    onSecondary: Colors.white,
    surface: const Color(0xFF212529),
    onSurface: Colors.white,
    background: const Color(0xFF2F3336),
    onBackground: Colors.white,
    error: const Color(0xFFE76E55),
    onError: Colors.white,
    brightness: Brightness.dark,
    outline: Colors.white,
  );

  // Default retro text theme with pixel-perfect font
  static final TextTheme _defaultRetroTextTheme = TextTheme(
    displayLarge: TextStyle(
      fontFamily: 'Press Start 2P',
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: _defaultRetroColorScheme.onBackground,
    ),
    displayMedium: TextStyle(
      fontFamily: 'Press Start 2P',
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: _defaultRetroColorScheme.onBackground,
    ),
    displaySmall: TextStyle(
      fontFamily: 'Press Start 2P',
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: _defaultRetroColorScheme.onBackground,
    ),
    headlineMedium: TextStyle(
      fontFamily: 'Press Start 2P',
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: _defaultRetroColorScheme.onBackground,
    ),
    titleLarge: TextStyle(
      fontFamily: 'Press Start 2P',
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: _defaultRetroColorScheme.onBackground,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'Press Start 2P',
      fontSize: 12,
      color: _defaultRetroColorScheme.onBackground,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Press Start 2P',
      fontSize: 10,
      color: _defaultRetroColorScheme.onBackground,
    ),
    labelLarge: TextStyle(
      fontFamily: 'Press Start 2P',
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: _defaultRetroColorScheme.onBackground,
    ),
  );

  // Default retro shadow
  static final BoxShadow _defaultRetroShadow = BoxShadow(
    color: Colors.black.withOpacity(0.5),
    offset: const Offset(4, 4),
    blurRadius: 0, // Sharp shadow for pixel-perfect look
    spreadRadius: 0,
  );
}