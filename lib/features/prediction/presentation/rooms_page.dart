import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:porrapp_frontend/core/util/util.dart';
import 'package:porrapp_frontend/features/prediction/domain/models/models.dart';
import 'package:porrapp_frontend/features/prediction/presentation/bloc/bloc.dart';

class RoomsPage extends StatelessWidget {
  static const String routeName = 'rooms';

  final int competitionId;

  const RoomsPage({super.key, required this.competitionId});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RoomBloc>();

    return Scaffold(
      appBar: AppBar(title: const Text('Rooms')),
      body: BlocBuilder<RoomBloc, RoomState>(
        builder: (context, state) {
          print('Building RoomsPage with state: $state');
          // Display loading indicator while rooms are being loaded
          if (state.room is Loading) {
            return const Center(child: CircularProgressIndicator());
          }
          // Display error message if there was an error loading rooms
          else if (state.room is Error) {
            return Center(child: Text('Error: ${state.room}'));
          }
          // Display list of rooms if successfully loaded
          else if (state.room is Success<List<RoomModel>>) {
            final rooms = (state.room as Success<List<RoomModel>>).data;
            return Stack(
              children: [
                ListView.builder(
                  itemCount: rooms.length,
                  itemBuilder: (context, index) {
                    final room = rooms[index];
                    return ListTile(
                      title: Text(room.name),
                      subtitle: Text(
                        'Competition ID: ${room.competition} - Room ID: ${room.id}',
                      ),
                    );
                  },
                ),

                Positioned(
                  bottom: 20,
                  right: 20,
                  child: FloatingActionButton(
                    onPressed: () {
                      bloc.add(CreateRoomEvent("test", competitionId));
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
    );
  }
}
