# Portal UI Kit

A reusable Flutter UI kit with configurable themes, including a retro theme inspired by [NES.css](https://nostalgic-css.github.io/NES.css/).

## Features

- **Configurable Themes**: Easily switch between themes or create your own
- **Retro Theme**: Pixel-perfect styling inspired by 8-bit design
- **Theme Switching**: Change themes programmatically or via UI widgets
- **Common UI Components**: Pre-styled buttons, text fields, cards, dialogs, and more
- **Highly Customizable**: Adjust colors, fonts, border styles, and more

## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  portal_ui_kit: ^0.0.1
```

Or use the local path if you're working with the source code:

```yaml
dependencies:
  portal_ui_kit:
    path: ../portal_ui_kit
```

## Required Font

For the retro theme to work properly, you need to include the "Press Start 2P" font in your project:

1. Add the font to your assets:

```yaml
flutter:
  fonts:
    - family: Press Start 2P
      fonts:
        - asset: assets/fonts/PressStart2P-Regular.ttf
```

2. Download the font from [Google Fonts](https://fonts.google.com/specimen/Press+Start+2P) and place it in your assets folder.

## Usage

### Basic Setup

Wrap your app with the `ThemeProvider` to enable theme functionality:

```dart
import 'package:flutter/material.dart';
import 'package:portal_ui_kit/portal_ui_kit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThemeProvider.createProvider(
      themes: [
        RetroTheme(),
        RetroTheme.dark(),
        // Add more themes as needed
      ],
      initialThemeName: 'Retro',
      child: Builder(
        builder: (context) {
          // Get the current theme from the provider
          final themeData = context.themeData;
          
          return MaterialApp(
            title: 'My App',
            theme: themeData,
            home: const HomePage(),
          );
        },
      ),
    );
  }
}
```

### Using Components

The UI kit provides various pre-styled components:

```dart
// Buttons
StyledButton(
  onPressed: () {},
  variant: ButtonVariant.primary,
  child: const Text('Primary Button'),
)

// Text Fields
StyledTextField(
  labelText: 'Username',
  hintText: 'Enter your username',
)

// Cards
StyledCard(
  title: 'Card Title',
  subtitle: 'Card Subtitle',
  child: const Text('Card content goes here'),
)

// Dialogs
StyledAlertDialog.show(
  context: context,
  title: 'Information',
  message: 'This is an information dialog.',
  type: DialogType.info,
)

// Toast Messages
StyledToast.show(
  context, 
  'This is a toast message', 
  type: ToastType.success
)
```

### Switching Themes

#### Programmatically

```dart
// Get the theme provider
final themeProvider = context.themeProvider;

// Change the theme
themeProvider.setTheme('Retro Dark');
```

#### Using UI Widgets

```dart
// Dropdown theme switcher
ThemeSwitcher(
  title: 'Select Theme',
  style: ThemeSwitcherStyle.dropdown,
)

// Floating action button theme switcher
ThemeSwitcherFab()
```

### Creating Custom Themes

You can create custom themes by extending the base `ThemeConfig` class or using the factory methods:

```dart
// Using RetroTheme.custom factory
final customTheme = RetroTheme.custom(
  name: 'Custom Green',
  primaryColor: const Color(0xFF4CAF50),
  backgroundColor: const Color(0xFFE8F5E9),
  textColor: const Color(0xFF1B5E20),
);

// Add the theme to the provider
context.themeProvider.addTheme(customTheme);
```

## Components

### Buttons
- `StyledButton`: Standard button with various styles
- `StyledIconButton`: Icon button with various styles

### Text Fields
- `StyledTextField`: Standard text input field
- `StyledTextArea`: Multiline text input
- `StyledSearchField`: Search field with search icon

### Cards and Containers
- `StyledCard`: Card with optional title, subtitle, and footer
- `StyledContainer`: Simple container with border and shadow options

### Dialogs and Notifications
- `StyledDialog`: Customizable dialog
- `StyledAlertDialog`: Pre-configured dialog with icon and standard buttons
- `StyledToast`: Toast message system

### Theme Switching
- `ThemeSwitcher`: Widget for switching between available themes
- `ThemeSwitcherFab`: Floating action button for theme switching

## Example

Check out the example app in the `example` directory for a complete demonstration of all components and features.

## License

This project is licensed under the MIT License - see the LICENSE file for details.