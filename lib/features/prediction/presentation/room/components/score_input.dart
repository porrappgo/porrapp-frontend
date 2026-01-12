import 'package:flutter/material.dart';

class ScoreInput extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String)? onChanged;

  const ScoreInput({super.key, required this.controller, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        decoration: const InputDecoration(border: OutlineInputBorder()),
      ),
    );
  }
}
