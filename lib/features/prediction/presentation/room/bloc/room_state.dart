part of 'room_bloc.dart';

sealed class RoomState extends Equatable {
  const RoomState();

  @override
  List<Object> get props => [];
}

final class RoomInitial extends RoomState {}

final class RoomLoading extends RoomState {}

final class RoomError extends RoomState {
  final String message;

  const RoomError(this.message);

  @override
  List<Object> get props => [message];
}

final class RoomHasData extends RoomState {
  final List<PredictionModel> predictions;

  const RoomHasData(this.predictions);

  @override
  List<Object> get props => [predictions];
}
