import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:porrapp_frontend/features/prediction/presentation/room/bloc/room_bloc.dart';

class RoomPage extends StatefulWidget {
  static const String routeName = 'room';

  final int roomId;

  const RoomPage({super.key, required this.roomId});

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  @override
  void initState() {
    super.initState();
    context.read<RoomBloc>().add(LoadRoomEvent(widget.roomId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Room Page')),
      body: BlocBuilder<RoomBloc, RoomState>(
        builder: (context, state) {
          if (state is RoomLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RoomHasData) {
            return ListView.builder(
              itemCount: state.predictions.length,
              itemBuilder: (context, index) {
                final prediction = state.predictions[index];
                return ListTile(
                  title: Text('Prediction ${prediction.id}'),
                  subtitle: Text('Details: ${prediction.match}'),
                );
              },
            );
          } else if (state is RoomError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }
}
