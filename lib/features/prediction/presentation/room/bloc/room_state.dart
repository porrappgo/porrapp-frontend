part of 'room_bloc.dart';

sealed class RoomState extends Equatable {
  const RoomState();

  @override
  List<Object?> get props => [];
}

final class RoomInitial extends RoomState {}

final class RoomLoading extends RoomState {}

final class RoomLeaveSuccess extends RoomState {}

final class RoomLeaveError extends RoomState {
  final String message;

  const RoomLeaveError(this.message);

  @override
  List<Object?> get props => [message];
}

final class RoomError extends RoomState {
  final String message;

  const RoomError(this.message);

  @override
  List<Object?> get props => [message];
}

final class RoomHasData extends RoomState {
  final List<PredictionModel> predictions;
  final List<RoomUserModel>? roomUsers;
  final bool isSaving;
  final bool hasChanges;
  final String? errorMessage;

  const RoomHasData({
    required this.predictions,
    this.roomUsers,
    this.isSaving = false,
    this.hasChanges = false,
    this.errorMessage,
  });

  RoomHasData copyWith({
    List<PredictionModel>? predictions,
    List<RoomUserModel>? roomUsers,
    bool? isSaving,
    bool? hasChanges,
    String? errorMessage,
  }) {
    return RoomHasData(
      predictions: predictions ?? this.predictions,
      roomUsers: roomUsers ?? this.roomUsers,
      isSaving: isSaving ?? this.isSaving,
      hasChanges: hasChanges ?? this.hasChanges,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    predictions,
    roomUsers,
    isSaving,
    hasChanges,
    errorMessage,
  ];
}
