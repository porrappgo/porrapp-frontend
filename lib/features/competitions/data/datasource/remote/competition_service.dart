import 'package:dio/dio.dart';
import 'package:porrapp_frontend/core/util/util.dart';
import 'package:porrapp_frontend/features/competitions/domain/models/models.dart';

class CompetitionService {
  final Dio _dio;

  CompetitionService(this._dio);

  Future<Resource<List<CompetitionModel>>> getAll() async {
    /**
     * Fetch all competitions from the remote API using the provided token.
     */
    try {
      final response = await _dio.get('/competition/');

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

  Future<Resource<List<GroupModel>>> getGroups(int competitionId) async {
    /**
     * Fetch groups for a specific competition from the remote API using the provided token.
     */
    try {
      final response = await _dio.get('/competition/groups/$competitionId/');

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Groups response data: ${response.data}');
        List<dynamic> data = response.data;
        List<GroupModel> groups = data
            .map((item) => GroupModel.fromJson(item))
            .toList();
        return Success<List<GroupModel>>(groups);
      } else {
        return Error(response.data);
      }
    } catch (e) {
      // Handle error
      print('Error during getting groups: $e');
      return Error('An error occurred during getting groups: ${e.toString()}');
    }
  }

  Future<Resource<List<GroupStandingModel>>> getGroupStandings(
    List<int> groupIds,
  ) async {
    /** Fetch group standings for specific group IDs from the remote API using the provided token. */
    try {
      final groupIdsParam = groupIds.join(',');
      final response = await _dio.get(
        '/competition/group-standings/$groupIdsParam/',
      );

      print('Group standings response status: ${response.realUri}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Groups standing response data: ${response.data}');
        List<dynamic> data = response.data;
        List<GroupStandingModel> groupStandings = data
            .map((item) => GroupStandingModel.fromJson(item))
            .toList();
        return Success<List<GroupStandingModel>>(groupStandings);
      } else {
        return Error(response.data);
      }
    } catch (e) {
      print('Error during getting group standings: $e');
      return Error(
        'An error occurred during getting group standings: ${e.toString()}',
      );
    }
  }

  Future<Resource<List<TeamModel>>> getTeams() async {
    /**
     * Fetch all teams from the remote API using the provided token.
     */
    try {
      final response = await _dio.get('/competition/teams/');

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Teams response data: ${response.data}');
        List<dynamic> data = response.data;
        List<TeamModel> teams = data
            .map((item) => TeamModel.fromJson(item))
            .toList();
        return Success<List<TeamModel>>(teams);
      } else {
        return Error(response.data);
      }
    } catch (e) {
      // Handle error
      print('Error during getting teams: $e');
      return Error('An error occurred during getting teams: ${e.toString()}');
    }
  }

  Future<Resource<List<MatchModel>>> getMatches() async {
    /**
     * Fetch all matches from the remote API using the provided token.
     */
    try {
      final response = await _dio.get('/competition/matches/');

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Matches response data: ${response.data}');
        List<dynamic> data = response.data;
        List<MatchModel> matches = data
            .map((item) => MatchModel.fromJson(item))
            .toList();
        return Success<List<MatchModel>>(matches);
      } else {
        return Error(response.data);
      }
    } catch (e) {
      // Handle error
      print('Error during getting matches: $e');
      return Error('An error occurred during getting matches: ${e.toString()}');
    }
  }
}
