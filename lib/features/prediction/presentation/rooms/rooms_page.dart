import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:porrapp_frontend/features/competitions/domain/models/competition_model.dart';
import 'package:porrapp_frontend/features/prediction/domain/models/room_user_model.dart';
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
      appBar: AppBar(title: const Text('PorrApp')),
      body: BlocListener<RoomsBloc, RoomsState>(
        listener: (context, state) {
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
                        final result = await showCreateRoomSheet(
                          context,
                          state.competitions,
                        );

                        if (result == null) return;
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

class CardRoom extends StatelessWidget {
  final RoomUserModel roomUser;
  final CompetitionModel competition;

  const CardRoom({
    super.key,
    required this.roomUser,
    required this.competition,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Stack(
        children: [
          Positioned(
            left: -15,
            top: -15,
            child: Opacity(
              opacity: 0.06,
              child: const FadeInImage(
                width: 70,
                height: 70,
                placeholder: AssetImage('assets/images/soccer_placeholder.png'),
                image: AssetImage('assets/images/soccer_placeholder.png'),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8, left: 8),
            child: ListTile(
              title: Text(
                roomUser.room.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Competition: ${competition.name}'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                context.push('/${RoomPage.routeName}', extra: roomUser.room);
              },
            ),
          ),
        ],
      ),
    );
  }
}
