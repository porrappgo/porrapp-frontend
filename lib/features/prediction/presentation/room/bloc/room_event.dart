part of 'room_bloc.dart';

sealed class RoomEvent extends Equatable {
  const RoomEvent();

  @override
  List<Object> get props => [];
}

final class LoadRoomEvent extends RoomEvent {
  final int roomId;

  const LoadRoomEvent(this.roomId);

  @override
  List<Object> get props => [roomId];
}

class UpdatePredictionLocally extends RoomEvent {
  final int predictionId;
  final int? homeScore;
  final int? awayScore;

  const UpdatePredictionLocally({
    required this.predictionId,
    required this.homeScore,
    required this.awayScore,
  });
}

class SavePredictions extends RoomEvent {}

class ClearRoomError extends RoomEvent {}
