import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:porrapp_frontend/features/competitions/domain/models/models.dart';

import 'package:porrapp_frontend/features/prediction/domain/models/models.dart';
import 'package:porrapp_frontend/features/prediction/presentation/rooms/bloc/rooms_bloc.dart';
import 'package:porrapp_frontend/features/prediction/presentation/rooms/components/card_room.dart';
import 'package:porrapp_frontend/features/prediction/presentation/rooms/components/new_room_dialog.dart';
import 'package:porrapp_frontend/features/prediction/presentation/rooms/components/rooms_no_yet.dart';

class RoomsPage extends StatelessWidget {
  static const String routeName = 'rooms';

  final String? codeRoom;

  const RoomsPage({super.key, this.codeRoom});

  @override
  Widget build(BuildContext context) {
    final roomsBloc = BlocProvider.of<RoomsBloc>(context);

    return Scaffold(
      appBar: AppBar(title: Text('PorrApp ${codeRoom ?? ''}')),
      body: BlocListener<RoomsBloc, RoomsState>(
        listener: (context, state) async {
          if (state is RoomsError) {
            Fluttertoast.showToast(
              msg: state.message,
              toastLength: Toast.LENGTH_LONG,
            );
          }

          if (state is RoomsCreated) {
            Fluttertoast.showToast(
              msg: 'Room "${state.room.name}" created successfully!',
              toastLength: Toast.LENGTH_LONG,
            );
            // Reload rooms after creating a new one
            roomsBloc.add(const LoadRoomsEvent());
          }

          if (state is RoomsHasData) {
            print('RoomsPage - codeRoom: $codeRoom');
            if (codeRoom != null && codeRoom!.isNotEmpty) {
              print('Attempting to join room with code: $codeRoom');
              await _displayCreateRoomDialog(context, state, roomsBloc);
            }
          }
        },
        child: BlocBuilder<RoomsBloc, RoomsState>(
          builder: (context, state) {
            // Display loading indicator while rooms are being loaded
            if (state is RoomsLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            // Display error message if there was an error loading rooms
            else if (state is RoomsError) {
              Fluttertoast.showToast(
                msg: state.message,
                toastLength: Toast.LENGTH_LONG,
              );
            }
            // Display list of rooms if successfully loaded
            else if (state is RoomsHasData) {
              final rooms = state.rooms;
              return Stack(
                children: [
                  if (rooms.isEmpty)
                    const RoomsNoYet()
                  else
                    _roomsList(rooms, state.competitions),

                  Positioned(
                    bottom: 20,
                    right: 20,
                    child: FloatingActionButton(
                      onPressed: () async {
                        await _displayCreateRoomDialog(
                          context,
                          state,
                          roomsBloc,
                        );
                      },
                      child: const Icon(Icons.add),
                    ),
                  ),
                ],
              );
            }

            return const Center(child: Text('No rooms available'));
          },
        ),
      ),
    );
  }

  Future<void> _displayCreateRoomDialog(
    BuildContext context,
    RoomsHasData state,
    RoomsBloc roomsBloc,
  ) async {
    final result = await showCreateRoomSheet(context, state.competitions);

    if (result == null) return;

    roomsBloc.add(CreateRoomEvent(result.name, result.competition.id));
  }

  ListView _roomsList(
    List<RoomUserModel> rooms,
    List<CompetitionModel> competitions,
  ) {
    return ListView.builder(
      itemCount: rooms.length,
      itemBuilder: (context, index) {
        final roomUser = rooms[index];
        final competition = competitions.firstWhere(
          (comp) => comp.id == roomUser.room.competition,
        );
        return CardRoom(roomUser: roomUser, competition: competition);
      },
    );
  }
}
