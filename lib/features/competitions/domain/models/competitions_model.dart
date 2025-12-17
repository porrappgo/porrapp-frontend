import 'package:porrapp_frontend/features/competitions/domain/models/models.dart';

class CompetitionsModel {
  CompetitionModel competion;
  List<GroupModel> groups;
  List<GroupStandingModel> groupStandings;
  List<TeamModel> teams;

  CompetitionsModel({
    required this.competion,
    required this.groups,
    required this.groupStandings,
    required this.teams,
  });
}
