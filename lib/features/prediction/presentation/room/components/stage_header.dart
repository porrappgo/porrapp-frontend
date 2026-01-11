import 'package:flutter/material.dart';

class StageHeader extends StatelessWidget {
  final String stageName;
  const StageHeader({super.key, required this.stageName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Text(
        stageName,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
