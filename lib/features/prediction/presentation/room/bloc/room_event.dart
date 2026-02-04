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

class UpdatePredictionLocallyEvent extends RoomEvent {
  final int predictionId;
  final int? homeScore;
  final int? awayScore;

  const UpdatePredictionLocallyEvent({
    required this.predictionId,
    required this.homeScore,
    required this.awayScore,
  });
}

class SavePredictionsEvent extends RoomEvent {}

class ClearRoomErrorEvent extends RoomEvent {}

class LeaveRoomEvent extends RoomEvent {
  final int roomId;

  const LeaveRoomEvent(this.roomId);

  @override
  List<Object> get props => [roomId];
}

class DeleteRoomEvent extends RoomEvent {
  final int roomId;

  const DeleteRoomEvent(this.roomId);

  @override
  List<Object> get props => [roomId];
}
