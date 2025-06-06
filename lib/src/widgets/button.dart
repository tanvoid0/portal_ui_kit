import 'package:flutter/material.dart';
import '../theme/theme_provider.dart';

/// A styled button that follows the theme configuration.
class StyledButton extends StatelessWidget {
  /// The child widget.
  final Widget child;

  /// The callback when the button is pressed.
  final VoidCallback? onPressed;

  /// The button style variant.
  final ButtonVariant variant;

  /// Whether the button is expanded to fill its parent.
  final bool expanded;

  /// The padding inside the button.
  final EdgeInsetsGeometry? padding;

  /// The button's size.
  final ButtonSize size;

  /// Constructor
  const StyledButton({
    Key? key,
    required this.child,
    this.onPressed,
    this.variant = ButtonVariant.primary,
    this.expanded = false,
    this.padding,
    this.size = ButtonSize.medium,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeConfig = context.themeConfig;
    final colorScheme = Theme.of(context).colorScheme;
    
    // Determine button colors based on variant
    Color backgroundColor;
    Color foregroundColor;
    Color borderColor;
    
    switch (variant) {
      case ButtonVariant.primary:
        backgroundColor = colorScheme.primary;
        foregroundColor = colorScheme.onPrimary;
        borderColor = colorScheme.outline;
        break;
      case ButtonVariant.secondary:
        backgroundColor = colorScheme.secondary;
        foregroundColor = colorScheme.onSecondary;
        borderColor = colorScheme.outline;
        break;
      case ButtonVariant.success:
        backgroundColor = Colors.green;
        foregroundColor = Colors.white;
        borderColor = colorScheme.outline;
        break;
      case ButtonVariant.danger:
        backgroundColor = colorScheme.error;
        foregroundColor = colorScheme.onError;
        borderColor = colorScheme.outline;
        break;
      case ButtonVariant.outline:
        backgroundColor = Colors.transparent;
        foregroundColor = colorScheme.primary;
        borderColor = colorScheme.primary;
        break;
      case ButtonVariant.text:
        backgroundColor = Colors.transparent;
        foregroundColor = colorScheme.primary;
        borderColor = Colors.transparent;
        break;
    }
    
    // Determine padding based on size
    final EdgeInsetsGeometry buttonPadding = padding ?? _getPaddingForSize(size);
    
    // Create button style
    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      padding: buttonPadding,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(themeConfig.borderRadius),
        side: BorderSide(
          color: borderColor,
          width: variant == ButtonVariant.text ? 0 : themeConfig.borderWidth,
        ),
      ),
      elevation: variant == ButtonVariant.text || variant == ButtonVariant.outline ? 0 : null,
    );
    
    // Create the button widget
    Widget button = ElevatedButton(
      onPressed: onPressed,
      style: buttonStyle,
      child: _applyPixelatedEffect(context, child),
    );
    
    // Wrap in a container if expanded
    if (expanded) {
      button = SizedBox(
        width: double.infinity,
        child: button,
      );
    }
    
    return button;
  }
  
  /// Apply pixelated effect if the theme is pixelated
  Widget _applyPixelatedEffect(BuildContext context, Widget child) {
    final themeConfig = context.themeConfig;
    
    if (themeConfig.pixelated) {
      // For pixelated themes, we use a specific font and avoid anti-aliasing
      return DefaultTextStyle(
        style: DefaultTextStyle.of(context).style.copyWith(
          fontFamily: 'Press Start 2P',
        ),
        child: child,
      );
    }
    
    return child;
  }
  
  /// Get padding based on button size
  EdgeInsetsGeometry _getPaddingForSize(ButtonSize size) {
    switch (size) {
      case ButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 8, vertical: 4);
      case ButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
      case ButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 12);
    }
  }
}

/// Button variants
enum ButtonVariant {
  /// Primary button (usually the main action)
  primary,
  
  /// Secondary button (alternative action)
  secondary,
  
  /// Success button (positive action)
  success,
  
  /// Danger button (destructive action)
  danger,
  
  /// Outline button (less emphasis)
  outline,
  
  /// Text button (minimal emphasis)
  text,
}

/// Button sizes
enum ButtonSize {
  /// Small button
  small,
  
  /// Medium button (default)
  medium,
  
  /// Large button
  large,
}

/// A styled icon button that follows the theme configuration.
class StyledIconButton extends StatelessWidget {
  /// The icon to display.
  final IconData icon;
  
  /// The callback when the button is pressed.
  final VoidCallback? onPressed;
  
  /// The button style variant.
  final ButtonVariant variant;
  
  /// The size of the icon.
  final double size;
  
  /// The tooltip text.
  final String? tooltip;
  
  /// Constructor
  const StyledIconButton({
    Key? key,
    required this.icon,
    this.onPressed,
    this.variant = ButtonVariant.primary,
    this.size = 24.0,
    this.tooltip,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final themeConfig = context.themeConfig;
    final colorScheme = Theme.of(context).colorScheme;
    
    // Determine button colors based on variant
    Color backgroundColor;
    Color foregroundColor;
    Color borderColor;
    
    switch (variant) {
      case ButtonVariant.primary:
        backgroundColor = colorScheme.primary;
        foregroundColor = colorScheme.onPrimary;
        borderColor = colorScheme.outline;
        break;
      case ButtonVariant.secondary:
        backgroundColor = colorScheme.secondary;
        foregroundColor = colorScheme.onSecondary;
        borderColor = colorScheme.outline;
        break;
      case ButtonVariant.success:
        backgroundColor = Colors.green;
        foregroundColor = Colors.white;
        borderColor = colorScheme.outline;
        break;
      case ButtonVariant.danger:
        backgroundColor = colorScheme.error;
        foregroundColor = colorScheme.onError;
        borderColor = colorScheme.outline;
        break;
      case ButtonVariant.outline:
        backgroundColor = Colors.transparent;
        foregroundColor = colorScheme.primary;
        borderColor = colorScheme.primary;
        break;
      case ButtonVariant.text:
        backgroundColor = Colors.transparent;
        foregroundColor = colorScheme.primary;
        borderColor = Colors.transparent;
        break;
    }
    
    Widget iconButton = IconButton(
      icon: Icon(icon, size: size),
      onPressed: onPressed,
      color: foregroundColor,
      tooltip: tooltip,
    );
    
    // For non-text variants, wrap in a container with border
    if (variant != ButtonVariant.text) {
      iconButton = Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(themeConfig.borderRadius),
          border: Border.all(
            color: borderColor,
            width: themeConfig.borderWidth,
          ),
        ),
        child: iconButton,
      );
    }
    
    return iconButton;
  }
}