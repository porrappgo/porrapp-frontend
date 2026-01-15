import 'package:flutter_test/flutter_test.dart';
import 'package:porrapp_frontend/features/prediction/domain/models/rooms_with_competitions.dart';
import 'package:porrapp_frontend/features/prediction/domain/models/room_user_model.dart';
import 'package:porrapp_frontend/features/prediction/domain/models/room_model.dart';
import 'package:porrapp_frontend/features/competitions/domain/models/competition_model.dart';

void main() {
  test('RoomsWithCompetitions stores rooms and competitions correctly', () {
    // Arrange
    final roomUser = RoomUserModel(
      room: RoomModel(id: 1, name: 'Test Room', competition: 10),
      totalPoints: 20,
      exactHits: 3,
      user: null,
    );

    final competition = CompetitionModel(
      id: 10,
      name: 'Test Competition',
      year: 2023,
      hostCountry: 'Test Country',
      logo: 'test_logo.png',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final rooms = [roomUser];
    final competitions = [competition];

    // Act
    final result = RoomsWithCompetitions(
      rooms: rooms,
      competitions: competitions,
    );

    // Assert
    expect(result.rooms, rooms);
    expect(result.competitions, competitions);
    expect(result.rooms.length, 1);
    expect(result.competitions.length, 1);
  });
}
