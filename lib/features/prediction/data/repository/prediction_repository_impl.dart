import 'package:porrapp_frontend/core/constants/constants.dart';
import 'package:porrapp_frontend/core/secure/secure_storage.dart';
import 'package:porrapp_frontend/core/util/resource.dart';

import 'package:porrapp_frontend/features/prediction/data/datasource/remote/prediction_service.dart';
import 'package:porrapp_frontend/features/prediction/domain/models/room_model.dart';
import 'package:porrapp_frontend/features/prediction/domain/repository/prediction_repository.dart';

class PredictionRepositoryImpl extends PredictionRepository {
  final PredictionService _predictionService;
  final ISecureStorageService _secureStorage;

  PredictionRepositoryImpl(this._predictionService, this._secureStorage);

  @override
  Future<Resource<RoomModel>> createRoom(RoomModel room) async {
    /**
     * Retrieve the token from secure storage
     * and create a new prediction room using the prediction service.
     */
    var token = await _getToken();
    if (token == null) {
      return Error('No token found');
    }

    return await _predictionService.createRoom(token, room);
  }

  @override
  Future<Resource<List<RoomModel>>> listRooms() {
    /**
     * Retrieve the token from secure storage
     * and list all prediction rooms using the prediction service.
     */
    return _getToken().then((token) {
      if (token == null) {
        return Future.value(Error('No token found'));
      }
      return _predictionService.listRooms(token);
    });
  }

  Future<String?> _getToken() async {
    return await _secureStorage.read(SecureStorageConstants.token);
  }
}
