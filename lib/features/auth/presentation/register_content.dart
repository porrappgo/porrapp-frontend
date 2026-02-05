import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import 'package:porrapp_frontend/core/components/components.dart';
import 'package:porrapp_frontend/core/util/util.dart';
import 'package:porrapp_frontend/features/auth/domain/model/model.dart';
import 'package:porrapp_frontend/features/auth/presentation/bloc/bloc.dart';
import 'package:porrapp_frontend/features/prediction/presentation/rooms/rooms_page.dart';
import 'package:porrapp_frontend/l10n/app_localizations.dart';

class RegisterContent extends StatefulWidget {
  static const String tag = 'RegisterContent';

  const RegisterContent({super.key});

  @override
  State<RegisterContent> createState() => _RegisterContentState();
}

class _RegisterContentState extends State<RegisterContent> {
  RegisterBloc? registerBloc;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    registerBloc = BlocProvider.of<RegisterBloc>(context);

    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        FlutterLogs.logInfo(
          RegisterContent.tag,
          'BlocListener',
          'Registration resource changed: ${state.registrationResource}',
        );
        if (state.registrationResource is Success<AuthModel>) {
          context.go('/${RoomsPage.routeName}');
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
                    label: localizations.emailLabel,
                    hint: localizations.emailHint,
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
                    label: localizations.nameLabel,
                    hint: localizations.nameHint,
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
                    label: localizations.passwordLabel,
                    hint: localizations.passwordHint,
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
                    label: localizations.confirmPasswordLabel,
                    hint: localizations.confirmPasswordHint,
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
                    text: localizations.registerButton,
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
                      localizations.alreadyHaveAccountLogin,
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
