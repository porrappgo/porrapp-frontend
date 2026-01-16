import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_logs/flutter_logs.dart';

import 'package:porrapp_frontend/core/bloc_providers.dart';
import 'package:porrapp_frontend/core/design/theme.dart';
import 'package:porrapp_frontend/core/env/env.dart';
import 'package:porrapp_frontend/core/injection.dart';
import 'package:porrapp_frontend/core/router/router.dart';
import 'package:porrapp_frontend/l10n/app_localizations.dart';

Future<void> bootstrap({required String env}) async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Initialize the environment configuration.
  late final Env envConfig = EnvUtil.getEnvConfig(env);
  // Configure the dependency injection.
  await configureDependencies(envConfig);
  // Run the app with the initialized environment configuration.
  runApp(PorraApp(envConfig: envConfig));
}

class PorraApp extends StatelessWidget {
  const PorraApp({super.key, required this.envConfig});

  final Env envConfig;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: blocProviders(),
      child: MaterialApp.router(
        supportedLocales: const [
          Locale('en'), // English
          Locale('es'), // Spanish
        ],
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          FlutterLogs.logInfo(
            'PorraApp',
            'localeResolutionCallback',
            'Device locale: ${locale?.languageCode}, Supported locales: $supportedLocales',
          );
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale?.languageCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        routerConfig: appRouter,
        title: envConfig.appName,
        theme: MaterialTheme(TextTheme()).light(),
        darkTheme: MaterialTheme(TextTheme()).dark(),
        themeMode: ThemeMode.system,
      ),
    );
  }
}
