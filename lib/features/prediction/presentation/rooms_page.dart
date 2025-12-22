import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      body: Stack(
        children: [
          Center(child: Text('Rooms Page Content')),
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
      ),
    );
  }
}
