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
  }

  void _onLoadRoomEvent(LoadRoomEvent event, Emitter<RoomState> emit) async {
    try {
      emit(RoomLoading());

      final resource = await predictionUseCases.getPredictionsForRoomUsecase
          .run(event.roomId);

      resource.fold(
        (failure) => emit(RoomError('Failed to load predictions')),
        (predictions) => emit(RoomHasData(predictions)),
      );
    } catch (e) {
      emit(RoomError('Failed to load predictions'));
    }
  }
}
