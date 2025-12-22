import 'package:equatable/equatable.dart';

class RoomEvent extends Equatable {
  const RoomEvent();

  @override
  List<Object> get props => [];
}

class CreateRoomEvent extends RoomEvent {
  final String roomName;
  final int competion;

  const CreateRoomEvent(this.roomName, this.competion);

  @override
  List<Object> get props => [roomName];
}
