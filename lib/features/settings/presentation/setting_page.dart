import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:porrapp_frontend/core/util/util.dart';
import 'package:porrapp_frontend/features/auth/presentation/login_page.dart';
import 'package:porrapp_frontend/features/settings/presentation/bloc/setting_bloc.dart';
import 'package:porrapp_frontend/features/settings/presentation/components/components.dart';

class SettingPage extends StatelessWidget {
  static const String tag = "SettingPage";
  static const String routeName = 'setting';

  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SettingBloc>();

    return BlocListener<SettingBloc, SettingState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          Fluttertoast.showToast(
            msg: "Logged out successfully",
            toastLength: Toast.LENGTH_LONG,
          );
          context.go('/${LoginPage.routeName}');
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Settings')),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            SectionTitle('General'),
            SettingsCard(
              children: [
                SettingsTile(
                  icon: Icons.email_outlined,
                  title: 'Comments or suggestions',
                  onTap: () async {
                    final Email email = Email(
                      subject: 'Feedback for PorrApp',
                      recipients: ['porrappgo@gmail.com'],
                    );

                    await FlutterEmailSender.send(email);
                  },
                ),
                // SettingsTile(
                //   icon: Icons.thumb_up_alt_outlined,
                //   title: 'Leave feedback',
                //   subtitle: 'Let us know how you like the app!',
                // ),
                // SettingsTile(icon: Icons.delete_outline, title: 'Clear cache'),
                // SettingsTile(
                //   icon: Icons.help_outline,
                //   title: 'FAQ',
                //   trailing: Icons.chevron_right,
                // ),
              ],
            ),
            SizedBox(height: 24),
            const SectionTitle('General'),
            const SettingsCard(
              children: [
                SettingsTile(
                  icon: Icons.privacy_tip_outlined,
                  title: 'Data privacy terms',
                  trailing: Icons.chevron_right,
                ),
                SettingsTile(
                  icon: Icons.description_outlined,
                  title: 'Terms and conditions',
                  trailing: Icons.chevron_right,
                ),
              ],
            ),
            const SizedBox(height: 24),
            SettingsTile(
              icon: Icons.logout,
              title: 'Sign out',
              isDestructive: true,
              onTap: () {
                messageDialog(
                  context: context,
                  title: 'Confirm Sign Out',
                  content: 'Are you sure you want to sign out?',
                  onConfirmed: () {
                    bloc.add(LogoutAppEvent());
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
