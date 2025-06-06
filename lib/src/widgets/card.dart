import 'package:flutter/material.dart';
import '../theme/theme_config.dart';
import '../theme/theme_provider.dart';

/// A styled card that follows the theme configuration.
class StyledCard extends StatelessWidget {
  /// The child widget.
  final Widget child;

  /// The card title.
  final String? title;

  /// The card subtitle.
  final String? subtitle;

  /// The padding inside the card.
  final EdgeInsetsGeometry padding;

  /// The margin around the card.
  final EdgeInsetsGeometry? margin;

  /// The card elevation.
  final double? elevation;

  /// The card color.
  final Color? color;

  /// The card border color.
  final Color? borderColor;

  /// The card border width.
  final double? borderWidth;

  /// The card border radius.
  final double? borderRadius;

  /// Whether to show a shadow.
  final bool showShadow;

  /// The header actions.
  final List<Widget>? actions;

  /// The footer widget.
  final Widget? footer;

  /// Constructor
  const StyledCard({
    Key? key,
    required this.child,
    this.title,
    this.subtitle,
    this.padding = const EdgeInsets.all(16.0),
    this.margin,
    this.elevation,
    this.color,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.showShadow = true,
    this.actions,
    this.footer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeConfig = context.themeConfig;
    final colorScheme = Theme.of(context).colorScheme;
    
    // Determine card properties
    final effectiveColor = color ?? colorScheme.surface;
    final effectiveBorderColor = borderColor ?? colorScheme.outline;
    final effectiveBorderWidth = borderWidth ?? themeConfig.borderWidth;
    final effectiveBorderRadius = borderRadius ?? themeConfig.borderRadius;
    final effectiveElevation = elevation ?? (showShadow ? 4.0 : 0.0);
    
    // Create card shape
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(effectiveBorderRadius),
      side: BorderSide(
        color: effectiveBorderColor,
        width: effectiveBorderWidth,
      ),
    );
    
    // Create card content
    Widget content = child;
    
    // Add header if title or subtitle is provided
    if (title != null || subtitle != null) {
      content = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          Padding(
            padding: padding,
            child: child,
          ),
        ],
      );
    } else {
      content = Padding(
        padding: padding,
        child: child,
      );
    }
    
    // Add footer if provided
    if (footer != null) {
      content = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null || subtitle != null)
            _buildHeader(context)
          else
            Padding(
              padding: padding,
              child: child,
            ),
          if (title == null && subtitle == null)
            const SizedBox()
          else
            Padding(
              padding: padding,
              child: child,
            ),
          Divider(
            color: effectiveBorderColor,
            thickness: effectiveBorderWidth / 2,
            height: effectiveBorderWidth,
          ),
          Padding(
            padding: padding,
            child: footer!,
          ),
        ],
      );
    }
    
    // Create the card
    Widget card = Card(
      margin: margin ?? const EdgeInsets.all(8.0),
      color: effectiveColor,
      elevation: effectiveElevation,
      shape: shape,
      child: content,
    );
    
    // Apply pixelated effect if needed
    if (themeConfig.pixelated && themeConfig.defaultShadow != null && showShadow) {
      card = Container(
        margin: margin ?? const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: effectiveColor,
          borderRadius: BorderRadius.circular(effectiveBorderRadius),
          border: Border.all(
            color: effectiveBorderColor,
            width: effectiveBorderWidth,
          ),
          boxShadow: [themeConfig.defaultShadow!],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(effectiveBorderRadius),
          child: content,
        ),
      );
    }
    
    return card;
  }
  
  /// Build the card header
  Widget _buildHeader(BuildContext context) {
    final themeConfig = context.themeConfig;
    final colorScheme = Theme.of(context).colorScheme;
    
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: colorScheme.primary.withOpacity(0.1),
        border: Border(
          bottom: BorderSide(
            color: borderColor ?? colorScheme.outline,
            width: borderWidth ?? themeConfig.borderWidth / 2,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null)
                  Text(
                    title!,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
              ],
            ),
          ),
          if (actions != null) ...actions!,
        ],
      ),
    );
  }
}

/// A styled container that follows the theme configuration.
class StyledContainer extends StatelessWidget {
  /// The child widget.
  final Widget child;

  /// The padding inside the container.
  final EdgeInsetsGeometry padding;

  /// The margin around the container.
  final EdgeInsetsGeometry? margin;

  /// The container color.
  final Color? color;

  /// The container border color.
  final Color? borderColor;

  /// The container border width.
  final double? borderWidth;

  /// The container border radius.
  final double? borderRadius;

  /// Whether to show a shadow.
  final bool showShadow;

  /// Constructor
  const StyledContainer({
    Key? key,
    required this.child,
    this.padding = const EdgeInsets.all(16.0),
    this.margin,
    this.color,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.showShadow = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeConfig = context.themeConfig;
    final colorScheme = Theme.of(context).colorScheme;
    
    // Determine container properties
    final effectiveColor = color ?? colorScheme.surface;
    final effectiveBorderColor = borderColor ?? colorScheme.outline;
    final effectiveBorderWidth = borderWidth ?? themeConfig.borderWidth;
    final effectiveBorderRadius = borderRadius ?? themeConfig.borderRadius;
    
    // Create container decoration
    BoxDecoration decoration = BoxDecoration(
      color: effectiveColor,
      borderRadius: BorderRadius.circular(effectiveBorderRadius),
      border: Border.all(
        color: effectiveBorderColor,
        width: effectiveBorderWidth,
      ),
    );
    
    // Add shadow if needed
    if (showShadow) {
      if (themeConfig.pixelated && themeConfig.defaultShadow != null) {
        decoration = decoration.copyWith(
          boxShadow: [themeConfig.defaultShadow!],
        );
      } else {
        decoration = decoration.copyWith(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        );
      }
    }
    
    // Create the container
    return Container(
      margin: margin,
      decoration: decoration,
      padding: padding,
      child: child,
    );
  }
}