part of 'rooms_bloc.dart';

sealed class RoomsEvent extends Equatable {
  const RoomsEvent();

  @override
  List<Object> get props => [];
}

class ResetRoomsEvent extends RoomsEvent {
  const ResetRoomsEvent();

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

class JoinRoomEvent extends RoomsEvent {
  final String invitationCode;

  const JoinRoomEvent(this.invitationCode);

  @override
  List<Object> get props => [invitationCode];
}

class LoadRoomsEvent extends RoomsEvent {
  const LoadRoomsEvent();

  @override
  List<Object> get props => [];
}

class LogoutFromAppEvent extends RoomsEvent {}
