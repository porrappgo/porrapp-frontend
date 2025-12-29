import 'package:flutter/material.dart';

class ButtonBase extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double width;
  final bool isDisabled;
  final bool isLoading;
  final bool isExpanded;

  /// Creates a customizable button base widget.
  ///
  /// [onPressed] is the callback function to be executed when the button is pressed.
  /// [text] is the label displayed on the button.
  /// [width] specifies the width of the button. Defaults to 0, which may indicate automatic sizing.
  /// [isDisabled] determines whether the button is disabled. Defaults to false.
  /// [isLoading] shows a loading indicator on the button when set to true. Defaults to false.
  /// [isExpanded] indicates whether the button should expand to fill its parent. Defaults to true.
  const ButtonBase({
    super.key,
    required this.onPressed,
    required this.text,
    this.width = 0,
    this.isDisabled = false,
    this.isLoading = false,
    this.isExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: isExpanded ? double.infinity : width,
      disabledColor: Colors.grey.shade400,
      disabledTextColor: Theme.of(context).colorScheme.onPrimary,
      onPressed: (isDisabled || isLoading) ? null : onPressed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
        child: isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 2.0),
              )
            : Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
      ),
    );
  }
}
