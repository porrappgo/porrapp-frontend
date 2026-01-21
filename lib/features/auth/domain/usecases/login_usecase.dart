import 'package:dartz/dartz.dart';
import 'package:porrapp_frontend/core/util/util.dart';
import 'package:porrapp_frontend/features/auth/domain/model/model.dart';
import 'package:porrapp_frontend/features/auth/domain/repository/auth_repository.dart';

class LoginUseCase {
  AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, AuthModel>> run() async {
    return await repository.login();
  }
}
