import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:porrapp_frontend/features/competitions/domain/models/models.dart';
import 'package:porrapp_frontend/features/competitions/domain/usecases/usecases.dart';
import 'package:porrapp_frontend/features/prediction/domain/models/models.dart';
import 'package:porrapp_frontend/features/prediction/domain/usecases/usecases.dart';

part 'rooms_event.dart';
part 'rooms_state.dart';

class RoomsBloc extends Bloc<RoomsEvent, RoomsState> {
  final PredictionUseCases predictionUseCases;

  RoomsBloc(this.predictionUseCases) : super(RoomsInitial()) {
    on<CreateRoomEvent>(_onCreateRoomEvent);
    on<LoadRoomsEvent>(_onLoadRoomsEvent);
  }

  void _onCreateRoomEvent(
    CreateRoomEvent event,
    Emitter<RoomsState> emit,
  ) async {
    try {
      emit(RoomsLoading());

      final resource = await predictionUseCases.createRoomUseCase.run(
        RoomModel(name: event.roomName, competition: event.competion),
      );

      resource.fold(
        (failure) => emit(RoomsError('Failed to create room')),
        (room) => emit(RoomsCreated(room)),
      );
    } catch (e) {
      emit(RoomsError('Failed to create room'));
    }
  }

  void _onLoadRoomsEvent(LoadRoomsEvent event, Emitter<RoomsState> emit) async {
    try {
      emit(RoomsLoading());

      final resource = await predictionUseCases.roomsWithCompetitionsUseCases
          .run();

      resource.fold(
        (failure) => emit(RoomsError('Failed to load rooms')),
        (roomsWithCompetitions) => emit(
          RoomsHasData(
            roomsWithCompetitions.rooms,
            roomsWithCompetitions.competitions,
          ),
        ),
      );
    } catch (e) {
      print('Error loading rooms: $e');
      emit(RoomsError('Failed to load rooms'));
    }
  }
}
