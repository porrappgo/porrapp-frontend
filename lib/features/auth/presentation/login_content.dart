import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:porrapp_frontend/core/components/components.dart';
import 'package:porrapp_frontend/core/util/util.dart';
import 'package:porrapp_frontend/features/auth/domain/model/model.dart';
import 'package:porrapp_frontend/features/auth/presentation/bloc/bloc.dart';
import 'package:porrapp_frontend/features/competitions/presentation/competition_page.dart';

class LoginContent extends StatefulWidget {
  const LoginContent({super.key});

  @override
  State<LoginContent> createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent> {
  AuthBloc? authBloc;

  @override
  Widget build(BuildContext context) {
    authBloc = BlocProvider.of<AuthBloc>(context);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        final responseState = state.response;
        print('LoginPage - responseState: $responseState');

        if (responseState is Success<AuthTokenModel>) {
          /// If login is successful, save the user session
          authBloc?.add(AuthSaveUserSession(response: responseState.data));
          context.go('/${CompetitionPage.routeName}');
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
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 16.0,
                children: [
                  // Title
                  SizedBox(height: 24.0),
                  SizedBox(
                    width: double.infinity,
                    child: const Text(
                      'Welcome Back',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Form fields
                  InputText(
                    label: 'Email',
                    hint: 'Enter your email',
                    onChanged: (text) {
                      authBloc?.add(
                        EmailChanged(email: BlocFormItem(value: text)),
                      );
                    },
                    validator: (value) {
                      print('Validating email: ${state.email.error}');
                      print('Value being validated: $value');
                      return state.email.error;
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  InputText(
                    label: 'Password',
                    hint: 'Enter your password',
                    isPassword: true,
                    onChanged: (text) {
                      authBloc?.add(
                        PasswordChanged(password: BlocFormItem(value: text)),
                      );
                    },
                    validator: (value) {
                      return state.password.error;
                    },
                    textInputAction: TextInputAction.done,
                  ),
                  const SizedBox(height: 20),
                  ButtonBase(
                    onPressed: () {
                      if (state.formKey?.currentState == null ||
                          !state.formKey!.currentState!.validate()) {
                        return;
                      }

                      authBloc?.add(const AuthSubmitted());
                    },
                    isLoading: state.response is LoadingPage,
                    isDisabled: state.response is LoadingPage,
                    text: 'Log In',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
