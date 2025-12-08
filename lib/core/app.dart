import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:porrapp_frontend/core/bloc_providers.dart';

import 'package:porrapp_frontend/core/design/colors.design.dart';
import 'package:porrapp_frontend/core/env/env.dart';
import 'package:porrapp_frontend/core/injection.dart';
import 'package:porrapp_frontend/core/router/router.dart';

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
        routerConfig: appRouter,
        title: envConfig.appName,
        theme: ThemeData(useMaterial3: true, colorScheme: lightScheme()),
        darkTheme: ThemeData(useMaterial3: true, colorScheme: darkScheme()),
        themeMode: ThemeMode.system,
      ),
    );
  }
}
