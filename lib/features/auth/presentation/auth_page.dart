import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  static const String routeName = 'auth';
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Authentication')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Handle authentication logic here.
          },
          child: const Text('Login'),
        ),
      ),
    );
  }
}
