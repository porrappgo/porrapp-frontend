import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  static const String tag = "SettingPage";
  static const String routeName = 'setting';

  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: const Center(child: Text('Settings Page Content')),
    );
  }
}
