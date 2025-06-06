import 'package:flutter/material.dart';
import '../theme/theme_provider.dart';

/// A styled dialog that follows the theme configuration.
class StyledDialog extends StatelessWidget {
  /// The dialog title.
  final String? title;

  /// The dialog content.
  final Widget content;

  /// The dialog actions.
  final List<Widget>? actions;

  /// The padding inside the dialog.
  final EdgeInsetsGeometry contentPadding;

  /// The padding around the title.
  final EdgeInsetsGeometry titlePadding;

  /// The padding around the actions.
  final EdgeInsetsGeometry actionsPadding;

  /// The dialog width.
  final double? width;

  /// The dialog border color.
  final Color? borderColor;

  /// The dialog border width.
  final double? borderWidth;

  /// The dialog border radius.
  final double? borderRadius;

  /// Constructor
  const StyledDialog({
    Key? key,
    this.title,
    required this.content,
    this.actions,
    this.contentPadding = const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
    this.titlePadding = const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0.0),
    this.actionsPadding = const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
    this.width,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeConfig = context.themeConfig;
    final colorScheme = Theme.of(context).colorScheme;
    
    // Determine dialog properties
    final effectiveBorderColor = borderColor ?? colorScheme.outline;
    final effectiveBorderWidth = borderWidth ?? themeConfig.borderWidth;
    final effectiveBorderRadius = borderRadius ?? themeConfig.borderRadius;
    
    // Create dialog shape
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(effectiveBorderRadius),
      side: BorderSide(
        color: effectiveBorderColor,
        width: effectiveBorderWidth,
      ),
    );
    
    // Create the dialog
    return Dialog(
      shape: shape,
      child: Container(
        width: width,
        constraints: BoxConstraints(
          maxWidth: width ?? 400,
          minWidth: 280,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (title != null) _buildTitle(context),
            Padding(
              padding: contentPadding,
              child: _applyPixelatedEffect(context, content),
            ),
            if (actions != null) _buildActions(context),
          ],
        ),
      ),
    );
  }
  
  /// Build the dialog title
  Widget _buildTitle(BuildContext context) {
    final themeConfig = context.themeConfig;
    final colorScheme = Theme.of(context).colorScheme;
    
    return Container(
      padding: titlePadding,
      decoration: BoxDecoration(
        color: colorScheme.primary.withOpacity(0.1),
        border: Border(
          bottom: BorderSide(
            color: borderColor ?? colorScheme.outline,
            width: borderWidth ?? themeConfig.borderWidth / 2,
          ),
        ),
      ),
      child: Text(
        title!,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
  
  /// Build the dialog actions
  Widget _buildActions(BuildContext context) {
    return Padding(
      padding: actionsPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: actions!,
      ),
    );
  }
  
  /// Apply pixelated effect if the theme is pixelated
  Widget _applyPixelatedEffect(BuildContext context, Widget child) {
    final themeConfig = context.themeConfig;
    
    if (themeConfig.pixelated) {
      return DefaultTextStyle(
        style: DefaultTextStyle.of(context).style.copyWith(
          fontFamily: 'Press Start 2P',
        ),
        child: child,
      );
    }
    
    return child;
  }
  
  /// Show the dialog
  static Future<T?> show<T>({
    required BuildContext context,
    String? title,
    required Widget content,
    List<Widget>? actions,
    EdgeInsetsGeometry contentPadding = const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
    EdgeInsetsGeometry titlePadding = const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0.0),
    EdgeInsetsGeometry actionsPadding = const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
    double? width,
    Color? borderColor,
    double? borderWidth,
    double? borderRadius,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => StyledDialog(
        title: title,
        content: content,
        actions: actions,
        contentPadding: contentPadding,
        titlePadding: titlePadding,
        actionsPadding: actionsPadding,
        width: width,
        borderColor: borderColor,
        borderWidth: borderWidth,
        borderRadius: borderRadius,
      ),
    );
  }
}

/// A styled alert dialog with predefined buttons.
class StyledAlertDialog extends StatelessWidget {
  /// The dialog title.
  final String title;

  /// The dialog message.
  final String message;

  /// The confirm button text.
  final String confirmText;

  /// The cancel button text.
  final String? cancelText;

  /// The callback when the confirm button is pressed.
  final VoidCallback? onConfirm;

  /// The callback when the cancel button is pressed.
  final VoidCallback? onCancel;

  /// The dialog type.
  final DialogType type;

  /// Constructor
  const StyledAlertDialog({
    Key? key,
    required this.title,
    required this.message,
    this.confirmText = 'OK',
    this.cancelText,
    this.onConfirm,
    this.onCancel,
    this.type = DialogType.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    // Determine icon and color based on type
    IconData icon;
    Color iconColor;
    
    switch (type) {
      case DialogType.info:
        icon = Icons.info_outline;
        iconColor = colorScheme.primary;
        break;
      case DialogType.success:
        icon = Icons.check_circle_outline;
        iconColor = Colors.green;
        break;
      case DialogType.warning:
        icon = Icons.warning_amber_outlined;
        iconColor = Colors.orange;
        break;
      case DialogType.error:
        icon = Icons.error_outline;
        iconColor = colorScheme.error;
        break;
    }
    
    // Create content
    final content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 48,
          color: iconColor,
        ),
        const SizedBox(height: 16),
        Text(
          message,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
    
    // Create actions
    final actions = <Widget>[
      if (cancelText != null)
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
            if (onCancel != null) {
              onCancel!();
            }
          },
          child: Text(cancelText!),
        ),
      TextButton(
        onPressed: () {
          Navigator.of(context).pop(true);
          if (onConfirm != null) {
            onConfirm!();
          }
        },
        child: Text(confirmText),
      ),
    ];
    
    // Create the dialog
    return StyledDialog(
      title: title,
      content: content,
      actions: actions,
    );
  }
  
  /// Show the alert dialog
  static Future<bool?> show({
    required BuildContext context,
    required String title,
    required String message,
    String confirmText = 'OK',
    String? cancelText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    DialogType type = DialogType.info,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => StyledAlertDialog(
        title: title,
        message: message,
        confirmText: confirmText,
        cancelText: cancelText,
        onConfirm: onConfirm,
        onCancel: onCancel,
        type: type,
      ),
    );
  }
}

/// Dialog types
enum DialogType {
  /// Information dialog
  info,
  
  /// Success dialog
  success,
  
  /// Warning dialog
  warning,
  
  /// Error dialog
  error,
}

/// A toast message that follows the theme configuration.
class StyledToast {
  /// Show a toast message
  static void show(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 2),
    ToastType type = ToastType.info,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final themeConfig = context.themeConfig;
    
    // Determine background color based on type
    Color backgroundColor;
    Color textColor;
    IconData icon;
    
    switch (type) {
      case ToastType.info:
        backgroundColor = colorScheme.primary;
        textColor = colorScheme.onPrimary;
        icon = Icons.info_outline;
        break;
      case ToastType.success:
        backgroundColor = Colors.green;
        textColor = Colors.white;
        icon = Icons.check_circle_outline;
        break;
      case ToastType.warning:
        backgroundColor = Colors.orange;
        textColor = Colors.white;
        icon = Icons.warning_amber_outlined;
        break;
      case ToastType.error:
        backgroundColor = colorScheme.error;
        textColor = colorScheme.onError;
        icon = Icons.error_outline;
        break;
    }
    
    // Create the snackbar
    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(
            icon,
            color: textColor,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: textColor,
                fontFamily: themeConfig.pixelated ? 'Press Start 2P' : null,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      duration: duration,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(themeConfig.borderRadius),
        side: BorderSide(
          color: colorScheme.outline,
          width: themeConfig.borderWidth,
        ),
      ),
      behavior: SnackBarBehavior.floating,
    );
    
    // Show the snackbar
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

/// Toast types
enum ToastType {
  /// Information toast
  info,
  
  /// Success toast
  success,
  
  /// Warning toast
  warning,
  
  /// Error toast
  error,
}