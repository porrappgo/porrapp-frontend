import 'package:flutter/material.dart';
import 'package:porrapp_frontend/core/env/env.dart';
import 'package:porrapp_frontend/core/injection.dart';
import 'package:porrapp_frontend/websocketpage.dart';

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
    return MaterialApp(
      title: envConfig.appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: WebSocketTestPage(),
    );
  }
}
