import 'package:flutter/material.dart';

/// A full-page loading indicator widget.
///
/// [CircularLoadingPage] displays a centered [CircularProgressIndicator] and
/// is typically used as a complete page overlay when loading data or waiting
/// for asynchronous operations to complete.
///
/// This widget is stateless and does not accept any parameters beyond the
/// standard [key] parameter.
///
/// Example usage:
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(builder: (context) => const CircularLoadingPage()),
/// );
/// ```
/// or as a replacement page:
/// ```dart
/// if (isLoading) {
///   return const CircularLoadingPage();
/// }
/// ```
class CircularLoadingPage extends StatelessWidget {
  /// Creates a [CircularLoadingPage].
  ///
  /// The [key] parameter is optional and is used to identify widgets
  /// in the widget tree.
  const CircularLoadingPage({super.key});

  /// Builds a centered circular loading indicator.
  ///
  /// This method returns a [Center] widget containing a [CircularProgressIndicator]
  /// that displays an indeterminate circular progress indicator centered on the screen.
  ///
  /// Parameters:
  ///   - [context]: The build context for this widget.
  ///
  /// Returns:
  ///   A [Widget] containing the centered loading indicator.
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: const Center(child: CircularProgressIndicator()));
  }
}
