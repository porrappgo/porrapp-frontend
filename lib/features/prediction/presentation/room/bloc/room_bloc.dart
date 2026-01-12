import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:porrapp_frontend/features/prediction/domain/models/models.dart';
import 'package:porrapp_frontend/features/prediction/domain/usecases/usecases.dart';

part 'room_event.dart';
part 'room_state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  final PredictionUseCases predictionUseCases;

  RoomBloc(this.predictionUseCases) : super(RoomInitial()) {
    on<LoadRoomEvent>(_onLoadRoomEvent);
    on<UpdatePredictionLocally>(_onUpdatePredictionLocally);
    on<SavePredictions>(_onSavePredictions);
  }

  void _onLoadRoomEvent(LoadRoomEvent event, Emitter<RoomState> emit) async {
    try {
      emit(RoomLoading());

      final resource = await predictionUseCases.getPredictionsForRoomUsecase
          .run(event.roomId);

      resource.fold(
        (failure) => emit(RoomError('Failed to load predictions')),
        (predictions) => emit(RoomHasData(predictions: predictions)),
      );
    } catch (e) {
      emit(RoomError('Failed to load predictions'));
    }
  }

  void _onUpdatePredictionLocally(
    UpdatePredictionLocally event,
    Emitter<RoomState> emit,
  ) {
    final current = state as RoomHasData;

    final updated = current.predictions.map((prediction) {
      if (prediction.id == event.predictionId) {
        print(
          'prediction id: ${prediction.id}, homeScore: ${event.homeScore}, awayScore: ${event.awayScore}',
        );
        return prediction.copyWith(
          predictedHomeScore: event.homeScore,
          predictedAwayScore: event.awayScore,
        );
      }
      return prediction;
    }).toList();

    emit(current.copyWith(predictions: updated, hasChanges: true));
  }

  void _onSavePredictions(
    SavePredictions event,
    Emitter<RoomState> emit,
  ) async {
    final current = state as RoomHasData;

    if (!_isValid(current.predictions)) {
      emit(
        current.copyWith(
          errorMessage: 'Please enter valid scores before saving.',
        ),
      );
      return;
    }

    emit(current.copyWith(isSaving: true, errorMessage: null));

    await Future.delayed(const Duration(seconds: 2));

    emit(
      current.copyWith(
        isSaving: false,
        errorMessage: 'Failed to save predictions. Please try again.',
      ),
    );
  }

  bool _isValid(List<PredictionModel> predictions) {
    for (final p in predictions) {
      if (p.predictedHomeScore == null ||
          p.predictedAwayScore == null ||
          p.predictedHomeScore! < 0 ||
          p.predictedAwayScore! < 0) {
        return false;
      }
    }
    return true;
  }
}
