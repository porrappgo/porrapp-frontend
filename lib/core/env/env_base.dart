/// An abstract class that defines the environment configuration for the application.
abstract class Env {
  /// - [env]: The name or type of the environment (e.g., 'development', 'production').
  String get env;

  /// - [baseUrl]: The base URL for API requests or backend services.
  String get baseUrl;

  /// - [appName]: The name of the application.
  String get appName;
}
