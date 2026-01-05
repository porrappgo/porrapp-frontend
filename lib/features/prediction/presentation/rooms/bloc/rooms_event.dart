part of 'rooms_bloc.dart';

sealed class RoomsEvent extends Equatable {
  const RoomsEvent();

  @override
  List<Object> get props => [];
}

class CreateRoomEvent extends RoomsEvent {
  final String roomName;
  final int competion;

  const CreateRoomEvent(this.roomName, this.competion);

  @override
  List<Object> get props => [roomName];
}

class LoadRoomsEvent extends RoomsEvent {
  const LoadRoomsEvent();

  @override
  List<Object> get props => [];
}
