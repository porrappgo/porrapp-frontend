import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_logs/flutter_logs.dart';

import 'package:porrapp_frontend/features/auth/domain/usecases/auth_usecases.dart';
import 'package:porrapp_frontend/features/competitions/domain/models/models.dart';
import 'package:porrapp_frontend/features/prediction/domain/models/models.dart';
import 'package:porrapp_frontend/features/prediction/domain/usecases/usecases.dart';

part 'rooms_event.dart';
part 'rooms_state.dart';

class RoomsBloc extends Bloc<RoomsEvent, RoomsState> {
  static const String tag = "RoomsBloc";

  final PredictionUseCases predictionUseCases;
  final AuthUseCases authUseCases;

  RoomsBloc(this.predictionUseCases, this.authUseCases)
    : super(RoomsInitial()) {
    on<ResetRoomsEvent>(_onResetRoomsEvent);
    on<CreateRoomEvent>(_onCreateRoomEvent);
    on<LoadRoomsEvent>(_onLoadRoomsEvent);
    on<LogoutFromAppEvent>(_onLogoutFromAppEvent);
  }

  void _onResetRoomsEvent(ResetRoomsEvent event, Emitter<RoomsState> emit) {
    emit(RoomsInitial());
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
      FlutterLogs.logError(
        tag,
        "_onLoadRoomsEvent",
        "Error in _onLoadRoomsEvent: $e",
      );
      emit(RoomsError('Failed to load rooms'));
    }
  }

  void _onLogoutFromAppEvent(
    LogoutFromAppEvent event,
    Emitter<RoomsState> emit,
  ) async {
    emit(LogoutLoading());

    try {
      await authUseCases.logout.run();
      emit(LogoutSuccess());
    } catch (e) {
      emit(LogoutError('Failed to logout. Please try again.'));
    }
  }
}
