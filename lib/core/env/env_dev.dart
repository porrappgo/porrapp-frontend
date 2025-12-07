import 'package:porrapp_frontend/core/constants/constants.dart';
import 'package:porrapp_frontend/core/env/env_base.dart';

class EnvDev implements Env {
  @override
  String get appName => "${BaseConstants.appName} [DEV]";

  @override
  String get baseUrl => 'http://192.168.1.14:8000/api';

  @override
  String get env => BaseConstants.dev;
}
