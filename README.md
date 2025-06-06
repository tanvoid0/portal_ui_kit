# Portal UI Kit

## Overview

The Portal UI Kit is a reusable UI kit for Flutter applications, providing a configurable theme with a retro style inspired by [Nes.css](https://github.com/suora/nes.css). This library makes it easy to create visually appealing and consistent interfaces for your Flutter apps.

## Features

* Configurable themes with customizable colors, text sizes, and borders
* Retro-style UI elements, such as pixelated buttons and bright colors
* Theme switcher widget to easily toggle between different themes
* Support for dark mode and custom theme options

## Usage

To use the Portal UI Kit in your Flutter app, follow these steps:

1. Add the library to your `pubspec.yaml` file:
```yaml
dependencies:
  portal_ui_kit: ^0.0.2
```

2. Import the library in your main Dart file:
```dart
import 'package:portal_ui_kit/portal_ui_kit.dart';
```

3. Wrap your app with the `ThemeProvider` widget and specify your themes:
```dart
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ThemeProvider.createProvider(
      themes: [
        RetroTheme(),
        RetroTheme.dark(),
        RetroTheme.custom(
          name: 'Retro Green',
          primaryColor: const Color(0xFF4CAF50),
          backgroundColor: const Color(0xFFE8F5E9),
          textColor: const Color(0xFF1B5E20),
        ),
      ],
      initialThemeName: 'Retro',
      initialThemeMode: ThemeMode.system,
      child: const MyApp(),
    ),
  );
}
```

4. Use the theme switcher widget in your app:
```dart
ThemeSwitcher(
  title: 'Theme Switcher',
  style: ThemeSwitcherStyle.dropdown,
  showThemeMode: true,
)
```


## Customization

You can customize the Portal UI Kit to fit your specific needs by modifying the `theme_config.dart` file. This file provides a set of pre-defined themes and color schemes that you can modify or extend.

### Example: Customizing the Retro Theme

To create a custom retro theme, you can modify the `RetroTheme` class in `theme/retro_theme.dart`. For example:
```dart
class CustomRetroTheme extends RetroTheme {
  const CustomRetroTheme({
    String name = 'Custom Retro',
    ColorScheme? colorScheme,
    TextTheme? textTheme,
    double borderRadius = 0.0, // Pixel-perfect corners
    double borderWidth = 4.0, // Thick borders
    BoxShadow? defaultShadow,
  }) : super(
          name: name,
          colorScheme: colorScheme ?? _defaultCustomRetroColorScheme,
          textTheme: textTheme ?? _defaultCustomRetroTextTheme,
          borderRadius: borderRadius,
          borderWidth: borderWidth,
          pixelated: true,

    );
}

// Custom colors scheme
class _CustomRetroColorScheme extends ColorScheme {
  @override
  Color get primaryColor => const Color(0xFF3498DB);
  @override
  Color get secondaryColor => const Color(0xFFF1C40F);
}
```

Note that this is just an example, and you can customize the `CustomRetroTheme` class to fit your specific needs.