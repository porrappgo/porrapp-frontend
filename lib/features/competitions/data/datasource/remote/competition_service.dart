import 'package:dio/dio.dart';
import 'package:porrapp_frontend/core/util/util.dart';
import 'package:porrapp_frontend/features/competitions/domain/models/competition_model.dart';

class CompetitionService {
  final Dio _dio;

  CompetitionService(this._dio);

  Future<Resource<List<CompetitionModel>>> getAll(String token) async {
    try {
      print('Attempting to get all competitions with token: $token');

      final response = await _dio.get(
        '/competition/',
        options: Options(headers: {"Authorization": "Token $token"}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Competitions response data: ${response.data}');
        List<dynamic> data = response.data;
        List<CompetitionModel> competitions = data
            .map((item) => CompetitionModel.fromJson(item))
            .toList();
        return Success<List<CompetitionModel>>(competitions);
      } else {
        return Error(response.data);
      }
    } catch (e) {
      // Handle error
      print('Error during getting competitions: $e');
      return Error(
        'An error occurred during getting competitions: ${e.toString()}',
      );
    }
  }
}
