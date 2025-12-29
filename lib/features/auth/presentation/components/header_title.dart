/// {@template header_title}
/// A stateless widget that displays the application header for authentication screens.
///
/// Renders a styled header containing the app logo (soccer icon) and "PorrApp" text
/// on a gradient background with a decorative wave-shaped bottom border.
///
/// The header features:
/// - A green gradient background (from lighter to darker green)
/// - Centered row layout with soccer icon and app name
/// - Wavy bottom border created using [_WaveClipper]
/// - Fixed height of 280 pixels with full width
///
/// Usage:
/// ```dart
/// Scaffold(
///   body: Column(
///     children: [
///       HeaderTitle(),
///       // ... rest of content
///     ],
///   ),
/// )
/// ```
///
/// See also:
/// - [_WaveClipper], which defines the custom wave shape for the header bottom
/// {@endtemplate}
library;

import 'package:flutter/material.dart';

class HeaderTitle extends StatelessWidget {
  const HeaderTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _WaveClipper(),
      child: Container(
        height: 280,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.sports_soccer,
              color: Theme.of(context).colorScheme.primary,
              size: 70,
            ),
            SizedBox(width: 10),
            Text(
              'PorrApp',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height - 60);

    // First curve (down)
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height - 100,
      size.width * 0.5,
      size.height - 60,
    );

    // Second curve (up)
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height - 20,
      size.width,
      size.height - 60,
    );

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
