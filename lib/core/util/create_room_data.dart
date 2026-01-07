import 'package:porrapp_frontend/features/competitions/domain/models/models.dart';

class CreateRoomData {
  final String name;
  final CompetitionModel competition;

  CreateRoomData({required this.name, required this.competition});
}
