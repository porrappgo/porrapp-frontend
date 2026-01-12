import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:porrapp_frontend/features/prediction/presentation/room/room_page.dart';
import 'package:porrapp_frontend/features/prediction/presentation/rooms/bloc/rooms_bloc.dart';
import 'package:porrapp_frontend/features/prediction/presentation/rooms/components/new_room_dialog.dart';
import 'package:porrapp_frontend/features/prediction/presentation/rooms/components/rooms_no_yet.dart';

class RoomsPage extends StatelessWidget {
  static const String routeName = 'rooms';

  const RoomsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final roomsBloc = BlocProvider.of<RoomsBloc>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Rooms')),
      body: BlocListener<RoomsBloc, RoomsState>(
        listener: (context, state) {
          print('RoomsPage BlocListener detected state change: $state');

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
        },
        child: BlocBuilder<RoomsBloc, RoomsState>(
          builder: (context, state) {
            print('Building RoomsPage with state: $state');
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
                    ListView.builder(
                      itemCount: rooms.length,
                      itemBuilder: (context, index) {
                        final room = rooms[index];
                        return ListTile(
                          title: Text(room.name),
                          subtitle: Text(
                            'Competition ID: ${room.competition} - Room ID: ${room.id}',
                          ),
                          onTap: () {
                            context.push(
                              '/${RoomPage.routeName}',
                              extra: room.id,
                            );
                          },
                        );
                      },
                    ),

                  Positioned(
                    bottom: 20,
                    right: 20,
                    child: FloatingActionButton(
                      onPressed: () async {
                        final result = await showCreateRoomSheet(
                          context,
                          state.competitions,
                        );
                        print('Create Room Sheet result: $result');

                        if (result == null) return;
                        print(
                          'Creating room with name: ${result.name}, '
                          'and competition: ${result.competition.id}',
                        );
                        roomsBloc.add(
                          CreateRoomEvent(result.name, result.competition.id),
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
}
