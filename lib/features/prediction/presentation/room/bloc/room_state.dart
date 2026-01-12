part of 'room_bloc.dart';

sealed class RoomState extends Equatable {
  const RoomState();

  @override
  List<Object?> get props => [];
}

final class RoomInitial extends RoomState {}

final class RoomLoading extends RoomState {}

final class RoomError extends RoomState {
  final String message;

  const RoomError(this.message);

  @override
  List<Object?> get props => [message];
}

final class RoomHasData extends RoomState {
  final List<PredictionModel> predictions;
  final bool isSaving;
  final bool hasChanges;
  final String? errorMessage;

  const RoomHasData({
    required this.predictions,
    this.isSaving = false,
    this.hasChanges = false,
    this.errorMessage,
  });

  RoomHasData copyWith({
    List<PredictionModel>? predictions,
    bool? isSaving,
    bool? hasChanges,
    String? errorMessage,
  }) {
    return RoomHasData(
      predictions: predictions ?? this.predictions,
      isSaving: isSaving ?? this.isSaving,
      hasChanges: hasChanges ?? this.hasChanges,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [predictions, isSaving, hasChanges, errorMessage];
}
