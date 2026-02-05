import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:porrapp_frontend/features/prediction/data/datasource/remote/prediction_service.dart';
import 'package:porrapp_frontend/features/prediction/domain/models/models.dart';
import 'package:porrapp_frontend/core/util/util.dart';

class MockDio extends Mock implements Dio {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockDio mockDio;
  late PredictionService service;

  const MethodChannel channel = MethodChannel('flutter_logs');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return 'Ok';
    });

    mockDio = MockDio();
    service = PredictionService(mockDio);
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  group('PredictionService', () {
    test('createRoom returns RoomModel when statusCode is 201', () async {
      // Arrange
      final room = RoomModel(id: 1, name: 'Test Room', competition: 1);
      final response = Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 201,
        data: room.toJson(),
      );

      when(
        () => mockDio.post('/prediction/rooms/create/', data: room.toJson()),
      ).thenAnswer((_) async => response);

      // Act
      final result = await service.createRoom(room);

      // Assert
      expect(result, isA<RoomModel>());
      expect(result.id, room.id);
      verify(
        () => mockDio.post('/prediction/rooms/create/', data: room.toJson()),
      ).called(1);
    });

    test(
      'createRoom throws ServerException when statusCode is not 201',
      () async {
        // Arrange
        final room = RoomModel(id: 1, name: 'Test Room', competition: 1);
        final response = Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 400,
          data: {},
        );

        when(
          () => mockDio.post(any(), data: any(named: 'data')),
        ).thenAnswer((_) async => response);

        // Act & Assert
        expect(() => service.createRoom(room), throwsA(isA<ServerException>()));
      },
    );

    test(
      'listRooms returns List<RoomUserModel> when statusCode is 200',
      () async {
        // Arrange
        final data = [
          {
            "room": {"id": 0, "name": "string", "competition": 0},
            "total_points": 2147483647,
            "exact_hits": 2147483647,
          },
          {
            "room": {"id": 1, "name": "string", "competition": 1},
            "total_points": 2147483647,
            "exact_hits": 2147483647,
          },
        ];

        final response = Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
          data: data,
        );

        when(
          () => mockDio.get('/prediction/room-users/'),
        ).thenAnswer((_) async => response);

        // Act
        final result = await service.listRooms();

        // Assert
        expect(result.length, 2);
        expect(result.first, isA<RoomUserModel>());
      },
    );

    test(
      'listRooms throws ServerException when statusCode is not 200',
      () async {
        // Arrange
        final response = Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 500,
          data: {},
        );

        when(() => mockDio.get(any())).thenAnswer((_) async => response);

        // Act & Assert
        expect(() => service.listRooms(), throwsA(isA<ServerException>()));
      },
    );

    test(
      'listRoomsByRoomId returns List<RoomUserModel> when statusCode is 200',
      () async {
        // Arrange
        const roomId = 1;
        final data = [
          {
            "room": {"id": 1, "name": "string", "competition": 0},
            "total_points": 2147483647,
            "exact_hits": 2147483647,
          },
        ];

        final response = Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
          data: data,
        );

        when(
          () => mockDio.get('/prediction/room-users/$roomId/'),
        ).thenAnswer((_) async => response);

        // Act
        final result = await service.listRoomsByRoomId(roomId);

        // Assert
        expect(result.length, 1);
        expect(result.first, isA<RoomUserModel>());
      },
    );

    test(
      'listRoomsByRoomId throws ServerException when statusCode is not 200',
      () async {
        // Arrange
        when(() => mockDio.get(any())).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: ''),
            statusCode: 404,
            data: {},
          ),
        );

        // Act & Assert
        expect(
          () => service.listRoomsByRoomId(1),
          throwsA(isA<ServerException>()),
        );
      },
    );

    test(
      'getPredictions returns List<PredictionModel> when statusCode is 200',
      () async {
        // Arrange
        final data = [
          {
            "id": 0,
            "match": {
              "id": 0,
              "home_team": {
                "id": 0,
                "identifier": "string",
                "name": "string",
                "flag": "string",
                "competition": 0,
              },
              "away_team": {
                "id": 0,
                "identifier": "string",
                "name": "string",
                "flag": "string",
                "competition": 0,
              },
              "identifier": "string",
              "stage": "string",
              "date": "2026-01-13T07:41:23.485Z",
              "home_score": 2147483647,
              "away_score": 2147483647,
              "is_finished": true,
              "result_processed": true,
              "created_at": "2026-01-13T07:41:23.485Z",
              "updated_at": "2026-01-13T07:41:23.485Z",
              "competition": 0,
            },
            "predicted_home_score": 2147483647,
            "predicted_away_score": 2147483647,
            "points_earned": 0,
            "is_predicted": true,
          },
          {
            "id": 1,
            "match": {
              "id": 1,
              "home_team": {
                "id": 1,
                "identifier": "string",
                "name": "string",
                "flag": "string",
                "competition": 0,
              },
              "away_team": {
                "id": 1,
                "identifier": "string",
                "name": "string",
                "flag": "string",
                "competition": 1,
              },
              "identifier": "string",
              "stage": "string",
              "date": "2026-01-13T07:41:23.485Z",
              "home_score": 2147483647,
              "away_score": 2147483647,
              "is_finished": true,
              "result_processed": true,
              "created_at": "2026-01-13T07:41:23.485Z",
              "updated_at": "2026-01-13T07:41:23.485Z",
              "competition": 0,
            },
            "predicted_home_score": 2147483647,
            "predicted_away_score": 2147483647,
            "points_earned": 0,
            "is_predicted": true,
          },
        ];

        final response = Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
          data: data,
        );

        when(
          () => mockDio.get('/prediction/predictions/1/'),
        ).thenAnswer((_) async => response);

        // Act
        final result = await service.getPredictions(1);

        // Assert
        expect(result.length, 2);
        expect(result.first, isA<PredictionModel>());
      },
    );

    test(
      'getPredictions throws ServerException when statusCode is not 200',
      () async {
        // Arrange
        when(() => mockDio.get(any())).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: ''),
            statusCode: 403,
            data: {},
          ),
        );

        // Act & Assert
        expect(
          () => service.getPredictions(1),
          throwsA(isA<ServerException>()),
        );
      },
    );

    test('updatePredictions returns true when success is true', () async {
      // Arrange
      final update = PredictionUpdateModel(predictions: []);
      final response = Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 200,
        data: {'success': true},
      );

      when(
        () => mockDio.patch(
          '/prediction/predictions/update/',
          data: update.toJson(),
        ),
      ).thenAnswer((_) async => response);

      // Act
      final result = await service.updatePredictions(update);

      // Assert
      expect(result, true);
    });

    test('updatePredictions returns false when success is false', () async {
      // Arrange
      final update = PredictionUpdateModel(predictions: []);
      final response = Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 200,
        data: {'success': false},
      );

      when(
        () => mockDio.patch(any(), data: any(named: 'data')),
      ).thenAnswer((_) async => response);

      // Act
      final result = await service.updatePredictions(update);

      // Assert
      expect(result, false);
    });

    test(
      'updatePredictions throws ServerException when statusCode is not 200',
      () async {
        // Arrange
        final update = PredictionUpdateModel(predictions: []);

        when(() => mockDio.patch(any(), data: any(named: 'data'))).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: ''),
            statusCode: 500,
            data: {},
          ),
        );

        // Act & Assert
        expect(
          () => service.updatePredictions(update),
          throwsA(isA<ServerException>()),
        );
      },
    );
  });
}
