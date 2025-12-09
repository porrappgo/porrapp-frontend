import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import 'package:porrapp_frontend/core/components/components.dart';
import 'package:porrapp_frontend/core/util/util.dart';
import 'package:porrapp_frontend/features/auth/domain/model/model.dart';
import 'package:porrapp_frontend/features/auth/presentation/bloc/bloc.dart';
import 'package:porrapp_frontend/websocketpage.dart';

class AuthPage extends StatefulWidget {
  static const String routeName = 'auth';
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  AuthBloc? authBloc;

  @override
  Widget build(BuildContext context) {
    authBloc = BlocProvider.of<AuthBloc>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Authentication')),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          final responseState = state.response;
          print('AuthPage - responseState: $responseState');

          if (responseState is Success<AuthTokenModel>) {
            /// If login is successful, save the user session
            print('Saving user session...');
            authBloc?.add(AuthSaveUserSession(response: responseState.data));
            context.go('/${WebSocketTestPage.routeName}');
          } else if (responseState is Error<AuthTokenModel>) {
            /// Show an error message if login fails
            Fluttertoast.showToast(
              msg: responseState.message,
              toastLength: Toast.LENGTH_LONG,
            );
            authBloc?.add(const AuthResetResource());
          }
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
                      decoration: InputDecorations.decoration(
                        labelText: 'E-mail',
                        hintText: 'Enter your e-mail',
                        prefixIcon: Icons.person,
                      ),
                      textInputAction: TextInputAction.next,
                      onChanged: (text) {
                        authBloc?.add(
                          EmailChanged(email: BlocFormItem(value: text)),
                        );
                      },
                      validator: (value) {
                        return state.email.error;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecorations.decoration(
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        prefixIcon: Icons.lock,
                      ),
                      textInputAction: TextInputAction.next,
                      onChanged: (text) {
                        authBloc?.add(
                          PasswordChanged(password: BlocFormItem(value: text)),
                        );
                      },
                      validator: (value) {
                        return state.email.error;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        authBloc?.add(const AuthSubmitted());
                      },
                      child: Text('Login'),
                    ),
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
