import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'theme_config.dart';
import 'retro_theme.dart';

/// ThemeProvider manages the current theme and provides methods to change it.
/// It uses Provider for state management and SharedPreferences for persistence.
class ThemeProvider extends ChangeNotifier {
  // SharedPreferences keys
  static const String _themeNameKey = 'portal_ui_kit_theme_name';
  static const String _themeModeKey = 'portal_ui_kit_theme_mode';
  static const String _themeColorsKey = 'portal_ui_kit_theme_colors';

  /// List of available themes
  final List<ThemeConfig> _availableThemes;

  /// Current theme configuration
  ThemeConfig _currentTheme;

  /// Current theme mode
  ThemeMode _themeMode;

  /// SharedPreferences instance for theme persistence
  final SharedPreferences _prefs;

  /// Constructor
  ThemeProvider._(this._availableThemes, this._currentTheme, this._themeMode, this._prefs);

  /// Factory constructor to create a ThemeProvider with default themes
  static Future<ThemeProvider> create({
    List<ThemeConfig>? themes,
    String? initialThemeName,
    ThemeMode initialThemeMode = ThemeMode.system,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    // Default themes if none provided
    final availableThemes = themes ?? [
      RetroTheme(),
      RetroTheme.dark(),
      // Add more default themes here
    ];

    // Get saved theme name or use initial theme name or first theme
    final savedThemeName = prefs.getString(_themeNameKey);
    final themeName = initialThemeName ?? savedThemeName ?? availableThemes.first.name;

    // Get saved theme mode or use initial theme mode
    final savedThemeMode = prefs.getString(_themeModeKey);
    ThemeMode themeMode = initialThemeMode;
    if (savedThemeMode != null) {
      themeMode = ThemeMode.values.firstWhere(
        (mode) => mode.toString() == savedThemeMode,
        orElse: () => initialThemeMode,
      );
    }

    // Find theme by name or use first theme
    var currentTheme = availableThemes.firstWhere(
      (theme) => theme.name == themeName,
      orElse: () => availableThemes.first,
    );

    // Apply saved custom colors if available
    final savedColors = prefs.getString(_themeColorsKey);
    if (savedColors != null) {
      try {
        final colorsMap = jsonDecode(savedColors) as Map<String, dynamic>;
        if (colorsMap.containsKey(currentTheme.name)) {
          final themeColors = colorsMap[currentTheme.name] as Map<String, dynamic>;
          currentTheme = _applyCustomColors(currentTheme, themeColors);
        }
      } catch (e) {
        print('Error loading saved colors: $e');
      }
    }

    return ThemeProvider._(availableThemes, currentTheme, themeMode, prefs);
  }

  /// Apply custom colors to a theme
  static ThemeConfig _applyCustomColors(ThemeConfig theme, Map<String, dynamic> colors) {
    // Create a new color scheme with the saved colors
    final currentColorScheme = theme.colorScheme;

    // Helper function to parse color from hex string
    Color parseColor(String hexColor) {
      return Color(int.parse(hexColor.substring(1), radix: 16) + 0xFF000000);
    }

    // Get colors from the map or use current colors
    final primary = colors['primary'] != null ? parseColor(colors['primary']) : currentColorScheme.primary;
    final secondary = colors['secondary'] != null ? parseColor(colors['secondary']) : currentColorScheme.secondary;
    final surface = colors['surface'] != null ? parseColor(colors['surface']) : currentColorScheme.surface;
    final background = colors['background'] != null ? parseColor(colors['background']) : currentColorScheme.surface;
    final error = colors['error'] != null ? parseColor(colors['error']) : currentColorScheme.error;

    // Create a new color scheme
    final newColorScheme = currentColorScheme.copyWith(
      primary: primary,
      secondary: secondary,
      surface: surface,
      error: error,
    );

    // Return a new theme with the updated color scheme
    return theme.copyWith(colorScheme: newColorScheme);
  }

  /// Get the current theme configuration
  ThemeConfig get theme => _currentTheme;

  /// Get the current theme data
  ThemeData get themeData => _currentTheme.toThemeData();

  /// Get the current theme mode
  ThemeMode get themeMode => _themeMode;

  /// Get the list of available themes
  List<ThemeConfig> get availableThemes => List.unmodifiable(_availableThemes);

  /// Change the current theme by name
  Future<void> setTheme(String themeName) async {
    final newTheme = _availableThemes.firstWhere(
      (theme) => theme.name == themeName,
      orElse: () => _currentTheme,
    );

    if (newTheme.name != _currentTheme.name) {
      _currentTheme = newTheme;
      await _prefs.setString(_themeNameKey, newTheme.name);

      // Load any saved custom colors for this theme
      final savedColors = _prefs.getString(_themeColorsKey);
      if (savedColors != null) {
        try {
          final colorsMap = jsonDecode(savedColors) as Map<String, dynamic>;
          if (colorsMap.containsKey(newTheme.name)) {
            final themeColors = colorsMap[newTheme.name] as Map<String, dynamic>;
            _currentTheme = _applyCustomColors(_currentTheme, themeColors);
          }
        } catch (e) {
          print('Error loading saved colors: $e');
        }
      }

      notifyListeners();
    }
  }

  /// Set the theme mode
  Future<void> setThemeMode(ThemeMode mode) async {
    if (mode != _themeMode) {
      _themeMode = mode;
      await _prefs.setString(_themeModeKey, mode.toString());
      notifyListeners();
    }
  }

  /// Update theme colors
  Future<void> updateThemeColors({
    Color? primary,
    Color? secondary,
    Color? surface,
    Color? background,
    Color? error,
  }) async {
    // Create a new color scheme with the updated colors
    final currentColorScheme = _currentTheme.colorScheme;
    final newColorScheme = currentColorScheme.copyWith(
      primary: primary ?? currentColorScheme.primary,
      secondary: secondary ?? currentColorScheme.secondary,
      surface: surface ?? currentColorScheme.surface,
      error: error ?? currentColorScheme.error,
    );

    // Create a new theme with the updated color scheme
    _currentTheme = _currentTheme.copyWith(colorScheme: newColorScheme);

    // Save the custom colors
    await _saveCustomColors();

    notifyListeners();
  }

  /// Save custom colors to SharedPreferences
  Future<void> _saveCustomColors() async {
    // Get current saved colors or create a new map
    Map<String, dynamic> colorsMap = {};
    final savedColors = _prefs.getString(_themeColorsKey);
    if (savedColors != null) {
      try {
        colorsMap = jsonDecode(savedColors) as Map<String, dynamic>;
      } catch (e) {
        print('Error loading saved colors: $e');
      }
    }

    // Helper function to convert color to hex string
    String colorToHex(Color color) {
      return '#${color.value.toRadixString(16).substring(2)}';
    }

    // Create a map of the current theme's colors
    final colorScheme = _currentTheme.colorScheme;
    final themeColors = {
      'primary': colorToHex(colorScheme.primary),
      'secondary': colorToHex(colorScheme.secondary),
      'surface': colorToHex(colorScheme.surface),
      'background': colorToHex(colorScheme.surface),
      'error': colorToHex(colorScheme.error),
    };

    // Add or update the colors for the current theme
    colorsMap[_currentTheme.name] = themeColors;

    // Save the updated colors map
    await _prefs.setString(_themeColorsKey, jsonEncode(colorsMap));
  }

  /// Reset theme colors to default
  Future<void> resetThemeColors() async {
    // Find the original theme
    final originalTheme = _availableThemes.firstWhere(
      (theme) => theme.name == _currentTheme.name,
      orElse: () => _currentTheme,
    );

    // Set the current theme to the original
    _currentTheme = originalTheme;

    // Remove custom colors for this theme
    Map<String, dynamic> colorsMap = {};
    final savedColors = _prefs.getString(_themeColorsKey);
    if (savedColors != null) {
      try {
        colorsMap = jsonDecode(savedColors) as Map<String, dynamic>;
        colorsMap.remove(_currentTheme.name);
        await _prefs.setString(_themeColorsKey, jsonEncode(colorsMap));
      } catch (e) {
        print('Error updating saved colors: $e');
      }
    }

    notifyListeners();
  }

  /// Add a new theme to the available themes
  Future<void> addTheme(ThemeConfig theme) async {
    // Check if theme with same name already exists
    final existingIndex = _availableThemes.indexWhere((t) => t.name == theme.name);

    if (existingIndex >= 0) {
      // Replace existing theme
      _availableThemes[existingIndex] = theme;
    } else {
      // Add new theme
      _availableThemes.add(theme);
    }

    notifyListeners();
  }

  /// Remove a theme from the available themes
  Future<void> removeTheme(String themeName) async {
    // Don't remove the current theme
    if (themeName == _currentTheme.name) {
      return;
    }

    _availableThemes.removeWhere((theme) => theme.name == themeName);
    notifyListeners();
  }

  /// Create a provider for the theme
  static Widget createProvider({
    List<ThemeConfig>? themes,
    String? initialThemeName,
    ThemeMode initialThemeMode = ThemeMode.system,
    required Widget child,
  }) {
    // Use a FutureBuilder to handle the async initialization
    return FutureBuilder<ThemeProvider>(
      future: ThemeProvider.create(
        themes: themes,
        initialThemeName: initialThemeName,
        initialThemeMode: initialThemeMode,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
          // Once the ThemeProvider is initialized, wrap the child with it
          return ChangeNotifierProvider<ThemeProvider>.value(
            value: snapshot.data!,
            child: child,
          );
        }

        // Show a loading indicator while the ThemeProvider is being initialized
        return const MaterialApp(
          home: Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }

  /// Get the theme provider from context
  static ThemeProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<ThemeProvider>(context, listen: listen);
  }
}

/// Extension methods for BuildContext to easily access the theme provider
extension ThemeProviderExtension on BuildContext {
  /// Get the theme provider
  ThemeProvider get themeProvider => ThemeProvider.of(this, listen: false);

  ThemeProvider get watchThemeProvider => ThemeProvider.of(this);

  /// Get the current theme configuration
  ThemeConfig get themeConfig => ThemeProvider.of(this, listen: false).theme;

  /// Get the current theme data
  ThemeData get themeData => ThemeProvider.of(this).themeData;

  /// Get the current theme mode
  ThemeMode get themeMode => ThemeProvider.of(this).themeMode;

  /// Get the list of available themes
  List<ThemeConfig> get availableThemes => ThemeProvider.of(this).availableThemes;
}
