part of 'rooms_bloc.dart';

sealed class RoomsState extends Equatable {
  const RoomsState();

  @override
  List<Object> get props => [];
}

// State initial when no action has been taken.
final class RoomsInitial extends RoomsState {}

// State when rooms are being loaded.
final class RoomsLoading extends RoomsState {}

// State when there was an error loading rooms.
final class RoomsError extends RoomsState {
  final String message;

  const RoomsError(this.message);

  @override
  List<Object> get props => [message];
}

// State when rooms have been successfully loaded.
final class RoomsHasData extends RoomsState {
  final List<RoomModel> rooms;

  const RoomsHasData(this.rooms);

  @override
  List<Object> get props => [rooms];
}
