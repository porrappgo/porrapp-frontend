import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:porrapp_frontend/core/components/components.dart';
import 'package:porrapp_frontend/core/util/util.dart';
import 'package:porrapp_frontend/features/auth/domain/model/model.dart';
import 'package:porrapp_frontend/features/auth/presentation/bloc/bloc.dart';
import 'package:porrapp_frontend/features/competitions/presentation/competition_page.dart';

class RegisterContent extends StatefulWidget {
  const RegisterContent({super.key});

  @override
  State<RegisterContent> createState() => _RegisterContentState();
}

class _RegisterContentState extends State<RegisterContent> {
  RegisterBloc? registerBloc;

  @override
  Widget build(BuildContext context) {
    registerBloc = BlocProvider.of<RegisterBloc>(context);

    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        print('Registration resource changed: ${state.registrationResource}');
        if (state.registrationResource is Success<AuthModel>) {
          print('Registration successful, navigating to CompetitionPage');
          context.go('/${CompetitionPage.routeName}');
        } else if (state.registrationResource is Error) {
          Fluttertoast.showToast(
            msg: (state.registrationResource as Error).message,
            toastLength: Toast.LENGTH_LONG,
          );
        } else if (state.registrationResource is Error<AuthModel>) {
          Fluttertoast.showToast(
            msg: (state.registrationResource as Error<AuthModel>).message,
            toastLength: Toast.LENGTH_LONG,
          );
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
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
                  // Form fields
                  InputText(
                    label: 'Email',
                    hint: 'Enter your email',
                    onChanged: (text) {
                      registerBloc?.add(
                        EmailChangedEvent(email: BlocFormItem(value: text)),
                      );
                    },
                    validator: (value) {
                      return state.email.error;
                    },
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  // Form fields
                  InputText(
                    label: 'Name',
                    hint: 'Enter your name',
                    onChanged: (text) {
                      registerBloc?.add(
                        NameChangedEvent(name: BlocFormItem(value: text)),
                      );
                    },
                    validator: (value) => state.name.error,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                  ),
                  InputText(
                    label: 'Password',
                    hint: 'Enter your password',
                    onChanged: (text) {
                      registerBloc?.add(
                        PasswordChangedEvent(
                          password: BlocFormItem(value: text),
                        ),
                      );
                    },
                    isPassword: true,
                    validator: (value) => state.password.error,
                    textInputAction: TextInputAction.next,
                  ),
                  InputText(
                    label: 'Confirm Password',
                    hint: 'Enter your password again',
                    onChanged: (text) {
                      registerBloc?.add(
                        ConfirmPasswordChangedEvent(
                          confirmPassword: BlocFormItem(value: text),
                        ),
                      );
                    },
                    isPassword: true,
                    validator: (value) => state.confirmPassword.error,
                    textInputAction: TextInputAction.done,
                  ),

                  const SizedBox(height: 20),
                  ButtonBase(
                    onPressed: () {
                      if (state.formKey?.currentState == null ||
                          !state.formKey!.currentState!.validate()) {
                        return;
                      }

                      registerBloc?.add(const RegisterFormSubmittedEvent());
                    },
                    text: 'Register',
                    isDisabled: state.isLoadingRegistration,
                    isLoading: state.isLoadingRegistration,
                  ),

                  const SizedBox(height: 16.0),
                  // Link to registration page.
                  GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: Text(
                      "Already have an account? Login",
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
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
