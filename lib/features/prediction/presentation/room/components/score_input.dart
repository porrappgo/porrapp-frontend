import 'package:flutter/material.dart';

class ScoreInput extends StatelessWidget {
  const ScoreInput({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: TextField(
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        decoration: const InputDecoration(border: OutlineInputBorder()),
      ),
    );
  }
}
