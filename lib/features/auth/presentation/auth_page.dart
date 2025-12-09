import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:porrapp_frontend/core/util/util.dart';
import 'package:porrapp_frontend/features/auth/presentation/bloc/bloc.dart';

class AuthPage extends StatelessWidget {
  static const String routeName = 'auth';
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Authentication')),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          final responseState = state.response;
          print('AuthPage - responseState: $responseState');
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            /// Loading page.
            if (state.response is LoadingPage) {
              return Center(child: CircularProgressIndicator());
            }

            return Form(
              key: state.formKey,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Username'),
                      onChanged: (value) {},
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      onChanged: (value) {},
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(onPressed: () {}, child: Text('Login')),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
