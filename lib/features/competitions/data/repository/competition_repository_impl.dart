import 'package:porrapp_frontend/core/constants/constants.dart';
import 'package:porrapp_frontend/core/secure/secure_storage.dart';
import 'package:porrapp_frontend/core/util/resource.dart';

import 'package:porrapp_frontend/features/competitions/data/datasource/remote/competition_service.dart';
import 'package:porrapp_frontend/features/competitions/domain/models/competition_model.dart';
import 'package:porrapp_frontend/features/competitions/domain/repository/competition_repository.dart';

class CompetitionRepositoryImpl extends CompetitionRepository {
  final CompetitionService _competitionService;
  final ISecureStorageService _secureStorage;

  CompetitionRepositoryImpl(this._competitionService, this._secureStorage);

  @override
  Future<Resource<List<CompetitionModel>>> getAll() async {
    var token = await _secureStorage.read(SecureStorageConstants.token);
    print('Retrieved token from secure storage: $token');
    if (token == null) {
      return Error('No token found');
    }

    return await _competitionService.getAll(token);
  }
}
