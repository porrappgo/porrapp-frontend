import 'package:porrapp_frontend/features/competitions/domain/models/models.dart';

class CompetitionsModel {
  CompetitionModel competion;
  GroupModel group;
  GroupStandingModel groupStanding;
  TeamModel team;

  CompetitionsModel({
    required this.competion,
    required this.group,
    required this.groupStanding,
    required this.team,
  });
}
