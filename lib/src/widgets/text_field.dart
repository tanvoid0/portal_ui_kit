import 'package:flutter/material.dart';
import '../theme/theme_config.dart';
import '../theme/theme_provider.dart';

/// A styled text field that follows the theme configuration.
class StyledTextField extends StatelessWidget {
  /// The controller for the text field.
  final TextEditingController? controller;

  /// The initial value of the text field.
  final String? initialValue;

  /// The hint text to display when the text field is empty.
  final String? hintText;

  /// The label text to display above the text field.
  final String? labelText;

  /// The helper text to display below the text field.
  final String? helperText;

  /// The error text to display below the text field.
  final String? errorText;

  /// Whether the text field is enabled.
  final bool enabled;

  /// Whether the text field is obscured (for passwords).
  final bool obscureText;

  /// The keyboard type.
  final TextInputType keyboardType;

  /// The text input action.
  final TextInputAction? textInputAction;

  /// The callback when the text field is submitted.
  final ValueChanged<String>? onSubmitted;

  /// The callback when the text field changes.
  final ValueChanged<String>? onChanged;

  /// The maximum number of lines.
  final int? maxLines;

  /// The minimum number of lines.
  final int? minLines;

  /// The maximum length of the text field.
  final int? maxLength;

  /// The prefix icon.
  final IconData? prefixIcon;

  /// The suffix icon.
  final IconData? suffixIcon;

  /// The callback when the suffix icon is pressed.
  final VoidCallback? onSuffixIconPressed;

  /// Constructor
  const StyledTextField({
    Key? key,
    this.controller,
    this.initialValue,
    this.hintText,
    this.labelText,
    this.helperText,
    this.errorText,
    this.enabled = true,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction,
    this.onSubmitted,
    this.onChanged,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeConfig = context.themeConfig;
    final colorScheme = Theme.of(context).colorScheme;
    
    // Create input decoration
    final InputDecoration decoration = InputDecoration(
      hintText: hintText,
      labelText: labelText,
      helperText: helperText,
      errorText: errorText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(themeConfig.borderRadius),
        borderSide: BorderSide(
          color: colorScheme.outline,
          width: themeConfig.borderWidth,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(themeConfig.borderRadius),
        borderSide: BorderSide(
          color: colorScheme.outline,
          width: themeConfig.borderWidth,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(themeConfig.borderRadius),
        borderSide: BorderSide(
          color: colorScheme.primary,
          width: themeConfig.borderWidth,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(themeConfig.borderRadius),
        borderSide: BorderSide(
          color: colorScheme.error,
          width: themeConfig.borderWidth,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(themeConfig.borderRadius),
        borderSide: BorderSide(
          color: colorScheme.error,
          width: themeConfig.borderWidth,
        ),
      ),
      prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
      suffixIcon: suffixIcon != null
          ? IconButton(
              icon: Icon(suffixIcon),
              onPressed: onSuffixIconPressed,
            )
          : null,
      filled: true,
      fillColor: enabled ? colorScheme.surface : colorScheme.surface.withOpacity(0.7),
    );
    
    // Apply pixelated style if needed
    TextStyle? textStyle;
    if (themeConfig.pixelated) {
      textStyle = TextStyle(
        fontFamily: 'Press Start 2P',
        color: colorScheme.onSurface,
      );
    }
    
    // Create the text field
    return TextField(
      controller: controller,
      decoration: decoration,
      style: textStyle,
      enabled: enabled,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onSubmitted: onSubmitted,
      onChanged: onChanged,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
    );
  }
}

/// A styled text area for multiline input.
class StyledTextArea extends StatelessWidget {
  /// The controller for the text area.
  final TextEditingController? controller;

  /// The initial value of the text area.
  final String? initialValue;

  /// The hint text to display when the text area is empty.
  final String? hintText;

  /// The label text to display above the text area.
  final String? labelText;

  /// The helper text to display below the text area.
  final String? helperText;

  /// The error text to display below the text area.
  final String? errorText;

  /// Whether the text area is enabled.
  final bool enabled;

  /// The minimum number of lines.
  final int minLines;

  /// The maximum number of lines.
  final int maxLines;

  /// The maximum length of the text area.
  final int? maxLength;

  /// The callback when the text area changes.
  final ValueChanged<String>? onChanged;

  /// Constructor
  const StyledTextArea({
    Key? key,
    this.controller,
    this.initialValue,
    this.hintText,
    this.labelText,
    this.helperText,
    this.errorText,
    this.enabled = true,
    this.minLines = 3,
    this.maxLines = 5,
    this.maxLength,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StyledTextField(
      controller: controller,
      initialValue: initialValue,
      hintText: hintText,
      labelText: labelText,
      helperText: helperText,
      errorText: errorText,
      enabled: enabled,
      minLines: minLines,
      maxLines: maxLines,
      maxLength: maxLength,
      onChanged: onChanged,
      keyboardType: TextInputType.multiline,
    );
  }
}

/// A styled search field.
class StyledSearchField extends StatelessWidget {
  /// The controller for the search field.
  final TextEditingController? controller;

  /// The hint text to display when the search field is empty.
  final String hintText;

  /// The callback when the search field changes.
  final ValueChanged<String>? onChanged;

  /// The callback when the search field is submitted.
  final ValueChanged<String>? onSubmitted;

  /// The callback when the clear button is pressed.
  final VoidCallback? onClear;

  /// Constructor
  const StyledSearchField({
    Key? key,
    this.controller,
    this.hintText = 'Search...',
    this.onChanged,
    this.onSubmitted,
    this.onClear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController effectiveController =
        controller ?? TextEditingController();

    return StyledTextField(
      controller: effectiveController,
      hintText: hintText,
      prefixIcon: Icons.search,
      suffixIcon: effectiveController.text.isNotEmpty ? Icons.clear : null,
      onSuffixIconPressed: () {
        effectiveController.clear();
        if (onClear != null) {
          onClear!();
        }
        if (onChanged != null) {
          onChanged!('');
        }
      },
      onChanged: (value) {
        if (onChanged != null) {
          onChanged!(value);
        }
      },
      onSubmitted: onSubmitted,
      textInputAction: TextInputAction.search,
    );
  }
}