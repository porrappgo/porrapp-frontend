import 'package:dartz/dartz.dart';
import 'package:porrapp_frontend/core/util/util.dart';
import 'package:porrapp_frontend/features/auth/domain/model/model.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthModel>> login();

  Future<Resource<bool>> logout();

  Future<bool> saveUserSession(String email, String access, String? refresh);
}
