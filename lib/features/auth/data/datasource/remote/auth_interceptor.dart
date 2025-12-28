import 'package:dio/dio.dart';
import 'package:porrapp_frontend/core/constants/constants.dart';
import 'package:porrapp_frontend/core/secure/secure_storage.dart';
import 'package:porrapp_frontend/core/util/util.dart';
import 'package:porrapp_frontend/features/auth/domain/repository/token_refresher_repository.dart';

class AuthInterceptor extends Interceptor {
  final ISecureStorageService secureStorage;
  final TokenRefresherRepository tokenRefresherRepository;

  AuthInterceptor(this.secureStorage, this.tokenRefresherRepository);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Skip adding Authorization header for requests marked with 'noAuth'.
    if (options.extra['noAuth'] == true) {
      return handler.next(options);
    }

    final token = await secureStorage.read(SecureStorageConstants.tokenAccess);

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 &&
        err.requestOptions.extra['noAuth'] != true) {
      final refreshResponse = await tokenRefresherRepository
          .refreshAccessToken();

      if (refreshResponse is Success<String>) {
        final newToken = refreshResponse.data;

        err.requestOptions.headers['Authorization'] = 'Bearer $newToken';

        final dio = Dio();
        final retryResponse = await dio.fetch(err.requestOptions);

        return handler.resolve(retryResponse);
      }
    }

    handler.next(err);
  }
}
