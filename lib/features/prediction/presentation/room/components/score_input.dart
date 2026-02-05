import 'package:flutter/material.dart';

class ScoreInput extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final bool isDisabled;

  const ScoreInput({
    super.key,
    required this.controller,
    this.onChanged,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      child: TextField(
        enabled: !isDisabled,
        maxLength: 2,
        controller: controller,
        onChanged: onChanged,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          counterText: '',
        ),
      ),
    );
  }
}
