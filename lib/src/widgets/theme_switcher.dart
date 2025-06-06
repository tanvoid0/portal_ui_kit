import 'package:flutter/material.dart';
import '../theme/theme_provider.dart';
import '../theme/theme_config.dart';

/// A widget that allows the user to switch between available themes.
class ThemeSwitcher extends StatelessWidget {
  /// The title of the theme switcher.
  final String? title;

  /// The style of the theme switcher.
  final ThemeSwitcherStyle style;

  /// Whether to show theme mode options.
  final bool showThemeMode;

  /// Whether to show color customization options.
  final bool showColorCustomization;

  /// Constructor
  const ThemeSwitcher({
    Key? key,
    this.title,
    this.style = ThemeSwitcherStyle.dropdown,
    this.showThemeMode = false,
    this.showColorCustomization = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.themeProvider;
    final currentTheme = themeProvider.theme;
    final availableThemes = themeProvider.availableThemes;
    final currentThemeMode = themeProvider.themeMode;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              title!,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        // Theme selector
        if (style == ThemeSwitcherStyle.dropdown)
            _buildDropdown(context, currentTheme, availableThemes)
        else if (style ==ThemeSwitcherStyle.radio)
            _buildRadioGroup(context, currentTheme, availableThemes)
          else if (style == ThemeSwitcherStyle.buttons)
            _buildButtonGroup(context, currentTheme, availableThemes),

        // Theme mode selector
        if (showThemeMode) ...[
          const SizedBox(height: 16),
          const Text('Theme Mode'),
          const SizedBox(height: 8),
          _buildThemeModeSelector(context, currentThemeMode),
        ],

        // Color customization
        if (showColorCustomization) ...[
          const SizedBox(height: 16),
          const Text('Color Customization'),
          const SizedBox(height: 8),
          _buildColorCustomization(context, currentTheme),
        ],
      ],
    );
  }

  /// Build a dropdown theme switcher
  Widget _buildDropdown(
    BuildContext context,
    ThemeConfig currentTheme,
    List<ThemeConfig> availableThemes,
  ) {
    return DropdownButton<String>(
      value: currentTheme.name,
      onChanged: (String? newValue) {
        if (newValue != null) {
          context.themeProvider.setTheme(newValue);
        }
      },
      items: availableThemes
          .map<DropdownMenuItem<String>>((ThemeConfig theme) {
        return DropdownMenuItem<String>(
          value: theme.name,
          child: Text(theme.name),
        );
      }).toList(),
    );
  }

  /// Build a radio group theme switcher
  Widget _buildRadioGroup(
    BuildContext context,
    ThemeConfig currentTheme,
    List<ThemeConfig> availableThemes,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: availableThemes.map((theme) {
        return RadioListTile<String>(
          title: Text(theme.name),
          value: theme.name,
          groupValue: currentTheme.name,
          onChanged: (String? value) {
            if (value != null) {
              ThemeProvider.of(context, listen: false).setTheme(value);
            }
          },
        );
      }).toList(),
    );
  }

  /// Build a button group theme switcher
  Widget _buildButtonGroup(
    BuildContext context,
    ThemeConfig currentTheme,
    List<ThemeConfig> availableThemes,
  ) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: availableThemes.map((theme) {
        final isSelected = theme.name == currentTheme.name;
        return ElevatedButton(
          onPressed: () {
            ThemeProvider.of(context, listen: false).setTheme(theme.name);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.surface,
            foregroundColor: isSelected
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.onSurface,
          ),
          child: Text(theme.name),
        );
      }).toList(),
    );
  }

  /// Build a theme mode selector
  Widget _buildThemeModeSelector(
    BuildContext context,
    ThemeMode currentThemeMode,
  ) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: [
        _buildThemeModeButton(
          context,
          ThemeMode.light,
          currentThemeMode,
          Icons.light_mode,
          'Light',
        ),
        _buildThemeModeButton(
          context,
          ThemeMode.dark,
          currentThemeMode,
          Icons.dark_mode,
          'Dark',
        ),
        _buildThemeModeButton(
          context,
          ThemeMode.system,
          currentThemeMode,
          Icons.settings_suggest,
          'System',
        ),
      ],
    );
  }

  /// Build a theme mode button
  Widget _buildThemeModeButton(
    BuildContext context,
    ThemeMode mode,
    ThemeMode currentMode,
    IconData icon,
    String label,
  ) {
    final isSelected = mode == currentMode;
    return ElevatedButton.icon(
      onPressed: () {
        ThemeProvider.of(context, listen: false).setThemeMode(mode);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.surface,
        foregroundColor: isSelected
            ? Theme.of(context).colorScheme.onPrimary
            : Theme.of(context).colorScheme.onSurface,
      ),
      icon: Icon(icon),
      label: Text(label),
    );
  }

  /// Build color customization controls
  Widget _buildColorCustomization(
    BuildContext context,
    ThemeConfig currentTheme,
  ) {
    final colorScheme = currentTheme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildColorPicker(
          context,
          'Primary',
          colorScheme.primary,
          (color) => ThemeProvider.of(context, listen: false).updateThemeColors(primary: color),
        ),
        const SizedBox(height: 8),
        _buildColorPicker(
          context,
          'Secondary',
          colorScheme.secondary,
          (color) => ThemeProvider.of(context, listen: false).updateThemeColors(secondary: color),
        ),
        const SizedBox(height: 8),
        _buildColorPicker(
          context,
          'Surface',
          colorScheme.surface,
          (color) => ThemeProvider.of(context, listen: false).updateThemeColors(surface: color),
        ),
        const SizedBox(height: 8),
        _buildColorPicker(
          context,
          'Background',
          colorScheme.surface,
          (color) => ThemeProvider.of(context, listen: false).updateThemeColors(background: color),
        ),
        const SizedBox(height: 8),
        _buildColorPicker(
          context,
          'Error',
          colorScheme.error,
          (color) => ThemeProvider.of(context, listen: false).updateThemeColors(error: color),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            ThemeProvider.of(context, listen: false).resetThemeColors();
          },
          child: const Text('Reset Colors'),
        ),
      ],
    );
  }

  /// Build a color picker
  Widget _buildColorPicker(
    BuildContext context,
    String label,
    Color currentColor,
    Function(Color) onColorChanged,
  ) {
    return Row(
      children: [
        Text('$label: '),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () {
            _showColorPickerDialog(context, label, currentColor, onColorChanged);
          },
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: currentColor,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(_colorToHex(currentColor)),
      ],
    );
  }

  /// Show color picker dialog
  void _showColorPickerDialog(
    BuildContext context,
    String label,
    Color currentColor,
    Function(Color) onColorChanged,
  ) {
    // This is a simplified color picker
    // In a real app, you would use a color picker package
    final List<Color> presetColors = [
      Colors.red,
      Colors.pink,
      Colors.purple,
      Colors.deepPurple,
      Colors.indigo,
      Colors.blue,
      Colors.lightBlue,
      Colors.cyan,
      Colors.teal,
      Colors.green,
      Colors.lightGreen,
      Colors.lime,
      Colors.yellow,
      Colors.amber,
      Colors.orange,
      Colors.deepOrange,
      Colors.brown,
      Colors.grey,
      Colors.blueGrey,
      Colors.black,
      Colors.white,
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select $label Color'),
        content: Container(
          width: 300,
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: presetColors.map((color) {
              final isSelected = color.value == currentColor.value;
              return GestureDetector(
                onTap: () {
                  onColorChanged(color);
                  Navigator.of(context).pop();
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: color,
                    border: Border.all(
                      color: isSelected ? Colors.black : Colors.grey,
                      width: isSelected ? 2 : 1,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  /// Convert color to hex string
  String _colorToHex(Color color) {
    return '#${color.value.toRadixString(16).substring(2)}';
  }
}

/// The style of the theme switcher.
enum ThemeSwitcherStyle {
  /// A dropdown menu.
  dropdown,

  /// A radio button group.
  radio,

  /// A group of buttons.
  buttons,
}

/// A floating action button that opens a theme switcher dialog.
class ThemeSwitcherFab extends StatelessWidget {
  /// The icon to use for the FAB.
  final IconData icon;

  /// The title of the theme switcher dialog.
  final String title;

  /// The style of the theme switcher.
  final ThemeSwitcherStyle style;

  /// Whether to show theme mode options.
  final bool showThemeMode;

  /// Whether to show color customization options.
  final bool showColorCustomization;

  /// Constructor
  const ThemeSwitcherFab({
    Key? key,
    this.icon = Icons.palette,
    this.title = 'Select Theme',
    this.style = ThemeSwitcherStyle.radio,
    this.showThemeMode = true,
    this.showColorCustomization = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ThemeSwitcher(
                style: style,
                showThemeMode: showThemeMode,
                showColorCustomization: showColorCustomization,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close'),
              ),
            ],
          ),
        );
      },
      child: Icon(icon),
    );
  }
}
