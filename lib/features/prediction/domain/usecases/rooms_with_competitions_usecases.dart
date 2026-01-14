import 'package:dartz/dartz.dart';
import 'package:porrapp_frontend/core/util/util.dart';
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
    final roomsResult = await predictionRepository.listRooms();

    return roomsResult.fold((failure) => Left(failure), (rooms) async {
      final competitionsResult = await competitionRepository.getAll();

      return competitionsResult.fold(
        (failure) => Left(failure),
        (competitions) => Right(
          RoomsWithCompetitions(rooms: rooms, competitions: competitions),
        ),
      );
    });
  }
}
