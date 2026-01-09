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
