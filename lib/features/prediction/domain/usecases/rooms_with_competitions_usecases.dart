import 'package:dartz/dartz.dart';
import 'package:porrapp_frontend/core/util/util.dart';
import 'package:porrapp_frontend/features/competitions/domain/models/models.dart';
import 'package:porrapp_frontend/features/competitions/domain/repository/competition_repository.dart';
import 'package:porrapp_frontend/features/prediction/domain/models/models.dart';
import 'package:porrapp_frontend/features/prediction/domain/repository/prediction_repository.dart';

class RoomsWithCompetitionsUseCases {
  PredictionRepository predictionRepository;
  CompetitionRepository competitionRepository;

  RoomsWithCompetitionsUseCases(
    this.predictionRepository,
    this.competitionRepository,
  );

  Future<Either<Failure, RoomsWithCompetitions>> run() async {
    try {
      final results = await Future.wait([
        predictionRepository.listRooms(),
        competitionRepository.getAll(),
      ]);

      final roomsResult = results[0] as Either<Failure, List<RoomModel>>;
      final competitionsResult =
          results[1] as Either<Failure, List<CompetitionModel>>;

      if (roomsResult.isLeft()) {
        return Left(
          roomsResult.fold(
            (l) => l,
            (_) => throw InternalFailure('Failed to load rooms'),
          ),
        );
      }

      if (competitionsResult.isLeft()) {
        return Left(
          competitionsResult.fold(
            (l) => l,
            (_) => throw InternalFailure('Failed to load competitions'),
          ),
        );
      }

      return Right(
        RoomsWithCompetitions(
          rooms: roomsResult.getOrElse(() => []),
          competitions: competitionsResult.getOrElse(() => []),
        ),
      );
    } catch (e) {
      return Left(InternalFailure('Failed to load rooms and competitions'));
    }
  }
}
