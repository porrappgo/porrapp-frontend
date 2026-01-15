import 'package:flutter_test/flutter_test.dart';
import 'package:porrapp_frontend/features/competitions/domain/models/models.dart';
import 'package:porrapp_frontend/features/prediction/domain/models/models.dart';

void main() {
  late MatchModel match;

  setUp(() {
    match = MatchModel(
      id: 10,
      homeTeam: TeamModel(
        id: 1,
        name: 'Team A',
        flag: 'http://example.com/cresta.png',
        competition: 1,
      ),
      awayTeam: TeamModel(
        id: 2,
        name: 'Team B',
        flag: 'http://example.com/cresta2.png',
        competition: 1,
      ),
      stage: "string",
      date: DateTime.now(),
      homeScore: 0,
      awayScore: 0,
      isFinished: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      competition: 1,
    );
  });

  test(
    'PredictionsWithUserRooms stores predictions and roomUsers correctly',
    () {
      // Arrange
      final predictions = <PredictionModel>[
        PredictionModel(
          id: 1,
          match: match,
          predictedHomeScore: 2,
          predictedAwayScore: 1,
          pointsEarned: 3,
        ),
      ];

      final roomUsers = <RoomUserModel>[
        RoomUserModel(
          room: RoomModel(id: 1, name: 'Room 1', competition: 1),
          totalPoints: 10,
          exactHits: 2,
          user: null,
        ),
      ];

      // Act
      final result = PredictionsWithUserRooms(
        predictions: predictions,
        roomUsers: roomUsers,
      );

      // Assert
      expect(result.predictions, predictions);
      expect(result.roomUsers, roomUsers);
      expect(result.predictions.length, 1);
      expect(result.roomUsers.length, 1);
    },
  );
}
