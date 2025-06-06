import 'package:flutter/material.dart';
import 'package:portal_ui_kit/src/theme/theme_factory.dart';
import 'theme_config.dart';

final retroTheme = ThemeFactory(
  name: 'Retro',
  lightColorScheme: const ColorScheme(
    primary: Color(0xFF209CEE),
    onPrimary: Colors.white,
    secondary: Color(0xFF92CC41),
    onSecondary: Colors.white,
    surface: Colors.white,
    onSurface: Color(0xFF212529),
    error: Color(0xFFE76E55),
    onError: Colors.white,
    brightness: Brightness.light,
    outline: Color(0xFF212529),
  ),
  darkColorScheme: const ColorScheme(
    primary: Color(0xFF209CEE),
    onPrimary: Colors.white,
    secondary: Color(0xFF92CC41),
    onSecondary: Colors.white,
    surface: Color(0xFF212529),
    onSurface: Colors.white,
    error: Color(0xFFE76E55),
    onError: Colors.white,
    brightness: Brightness.dark,
    outline: Colors.white,
  ),
  fontType: FontType.retro,
  borderRadius: 0.0,
  borderWidth: 4.0,
  pixelated: true,
).build();

final modernTheme = ThemeFactory(
  name: 'Modern',
  lightColorScheme: ColorScheme(
    primary: const Color(0xFF6200EE),
    onPrimary: Colors.white,
    secondary: const Color(0xFF03DAC6),
    onSecondary: Colors.black,
    surface: Colors.white,
    onSurface: Colors.black87,
    error: const Color(0xFFB00020),
    onError: Colors.white,
    brightness: Brightness.light,
    outline: Colors.grey.shade600,
  ),
  darkColorScheme: ColorScheme(
    primary: const Color(0xFFBB86FC),
    onPrimary: Colors.black,
    secondary: const Color(0xFF03DAC6),
    onSecondary: Colors.black,
    surface: const Color(0xFF121212),
    onSurface: Colors.white,
    error: const Color(0xFFCF6679),
    onError: Colors.black,
    brightness: Brightness.dark,
    outline: Colors.grey.shade400,
  ),
  fontType: FontType.modern,
  borderRadius: 12.0,     // increased radius for cards and buttons
  borderWidth: 1.5,
  pixelated: false,
).build();

final meisterTheme = ThemeFactory(
  name: 'MeisterTask',
  lightColorScheme: const ColorScheme(
    primary: Color(0xFF4A90E2),       // signature soft blue
    onPrimary: Colors.white,
    secondary: Color(0xFF50E3C2),     // teal accent
    onSecondary: Colors.white,
    surface: Colors.white,
    onSurface: Color(0xFF2D2D2D),
    error: Color(0xFFEA5455),         // soft red error
    onError: Colors.white,
    brightness: Brightness.light,
    outline: Color(0xFFD1D9E6),       // subtle light outline
  ),
  darkColorScheme: const ColorScheme(
    primary: Color(0xFF4A90E2),
    onPrimary: Colors.black,
    secondary: Color(0xFF50E3C2),
    onSecondary: Colors.black,
    surface: Color(0xFF121B22),
    onSurface: Colors.white,
    error: Color(0xFFEA5455),
    onError: Colors.black,
    brightness: Brightness.dark,
    outline: Color(0xFF304658),
  ),
  fontType: FontType.modern,           // no pixelation, clean font
  borderRadius: 8.0,                   // medium rounding for cards/buttons
  borderWidth: 1.0,                    // thin border for subtle UI
  pixelated: false,
).build();

final terminalAITheme = ThemeFactory(
  name: 'TerminalAI',
  lightColorScheme: const ColorScheme(
    primary: Color(0xFF00FF00),          // neon green
    onPrimary: Colors.black,
    secondary: Color(0xFF00BCD4),        // cyan accent
    onSecondary: Colors.black,
    surface: Color(0xFF1E1E1E),          // near-black surface
    onSurface: Color(0xFFE0E0E0),
    error: Color(0xFFFF5555),            // red for error
    onError: Colors.black,
    brightness: Brightness.dark,
    outline: Color(0xFF00FF00),          // green borders
  ),
  darkColorScheme: const ColorScheme(
    primary: Color(0xFF00FF00),
    onPrimary: Colors.black,
    secondary: Color(0xFF00BCD4),
    onSecondary: Colors.black,
    surface: Color(0xFF1E1E1E),
    onSurface: Color(0xFFE0E0E0),
    error: Color(0xFFFF5555),
    onError: Colors.black,
    brightness: Brightness.dark,
    outline: Color(0xFF00FF00),
  ),
  fontType: FontType.retro,     // assuming your `FontType.retro` uses a monospace font
  borderRadius: 0.0,            // sharp edges, no round corners
  borderWidth: 1.0,
  pixelated: true,              // optional: true for more "authentic terminal" effect
).build();



final List<ThemeConfig> customThemes = [
  ...retroTheme.allThemes,
  ...modernTheme.allThemes,
  ...meisterTheme.allThemes,
  ...terminalAITheme.allThemes,
];