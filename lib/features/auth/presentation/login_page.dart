import 'package:flutter/material.dart';
import 'package:porrapp_frontend/features/auth/presentation/components/header_title.dart';
import 'package:porrapp_frontend/features/auth/presentation/login_content.dart';

class LoginPage extends StatelessWidget {
  static const String routeName = 'login';

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Header with wave design
            const HeaderTitle(),
            // Login form
            const LoginContent(),
          ],
        ),
      ),
    );
  }
}
