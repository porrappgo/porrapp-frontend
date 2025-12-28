import 'package:flutter/material.dart';
import 'package:porrapp_frontend/features/auth/presentation/components/header_title.dart';

class RegisterPage extends StatelessWidget {
  static const String routeName = 'register';

  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Header with wave design
            const HeaderTitle(),
            // Registration form
            const Text('Registration Form Goes Here'),
          ],
        ),
      ),
    );
  }
}
