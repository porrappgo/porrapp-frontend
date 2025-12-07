import 'package:porrapp_frontend/core/constants/constants.dart';
import 'package:porrapp_frontend/core/env/env.dart';

/// Utility class for retrieving environment-specific configuration objects.
class EnvUtil {
  /// Retrieves the environment-specific configuration object based
  /// on the provided [env] string.
  static Env getEnvConfig(String env) {
    switch (env) {
      /// Development environment configuration.
      case BaseConstants.dev:
        return EnvDev();

      /// Default environment configuration.
      default:
        throw UnimplementedError('Env $env is not implemented');
    }
  }
}
