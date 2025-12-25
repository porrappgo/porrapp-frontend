import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:porrapp_frontend/core/util/util.dart';
import 'package:porrapp_frontend/features/prediction/domain/models/models.dart';
import 'package:porrapp_frontend/features/prediction/domain/usecases/usecases.dart';
import 'package:porrapp_frontend/features/prediction/presentation/bloc/bloc.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  final PredictionUseCases predictionUseCases;

  RoomBloc(this.predictionUseCases) : super(const RoomState()) {
    on<CreateRoomEvent>(_onCreateRoomEvent);
    on<LoadRoomsEvent>(_onLoadRoomsEvent);
  }

  void _onCreateRoomEvent(
    CreateRoomEvent event,
    Emitter<RoomState> emit,
  ) async {
    try {
      emit(state.copyWith(room: Loading()));

      final resource = await predictionUseCases.createRoomUseCase.run(
        RoomModel(name: event.roomName, competition: event.competion),
      );

      emit(state.copyWith(room: resource));
    } catch (e) {
      emit(state.copyWith(room: Error('Failed to create room')));
    }
  }

  void _onLoadRoomsEvent(LoadRoomsEvent event, Emitter<RoomState> emit) async {
    try {
      emit(state.copyWith(room: Loading()));

      final resource = await predictionUseCases.listRoomsUsecase.run();

      emit(state.copyWith(room: resource));
    } catch (e) {
      emit(state.copyWith(room: Error('Failed to load rooms')));
    }
  }
}
