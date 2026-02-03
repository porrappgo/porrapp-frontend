import 'package:flutter/material.dart';
import 'package:porrapp_frontend/l10n/app_localizations.dart';

/// Shows a localized alert dialog with a title, content, and optional actions.
///
/// If [onConfirmed] is provided, a confirm button is shown that closes the dialog
/// and then invokes the callback. A cancel button is always shown; if [onClosed]
/// is provided, it closes the dialog and invokes the callback, otherwise it only
/// closes the dialog.
///
/// Returns the [Future] from [showDialog] that completes when the dialog is
/// dismissed.
Future<dynamic> messageDialog({
  required BuildContext context,
  required String title,
  required String content,
  VoidCallback? onConfirmed,
  VoidCallback? onClosed,
}) {
  final localizations = AppLocalizations.of(context)!;

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          onConfirmed != null
              ? TextButton(
                  child: Text(localizations.confirmButton),
                  onPressed: () {
                    Navigator.of(context).pop();
                    onConfirmed();
                  },
                )
              : const SizedBox.shrink(),
          onClosed != null
              ? TextButton(
                  child: Text(localizations.cancelButton),
                  onPressed: () {
                    Navigator.of(context).pop();
                    onClosed();
                  },
                )
              : TextButton(
                  child: Text(localizations.cancelButton),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
        ],
      );
    },
  );
}
