import 'package:porrapp_frontend/features/competitions/domain/models/models.dart';
import 'package:porrapp_frontend/features/prediction/domain/models/models.dart';

class RoomsWithCompetitions {
  final List<RoomUserModel> rooms;
  final List<CompetitionModel> competitions;

  RoomsWithCompetitions({required this.rooms, required this.competitions});
}
