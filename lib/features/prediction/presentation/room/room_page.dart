import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:porrapp_frontend/features/prediction/domain/models/models.dart';
import 'package:porrapp_frontend/features/prediction/presentation/room/bloc/room_bloc.dart';
import 'package:porrapp_frontend/features/prediction/presentation/room/components/prediction_card.dart';
import 'package:porrapp_frontend/features/prediction/presentation/room/components/stage_header.dart';

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
          } else if (state is RoomError) {
            return Center(child: Text(state.message));
          } else if (state is RoomHasData) {
            final groupedPredictions = <String, List<PredictionModel>>{};

            for (final prediction in state.predictions) {
              final stage = prediction.match.stage;
              groupedPredictions.putIfAbsent(stage, () => []);
              groupedPredictions[stage]!.add(prediction);
            }

            List<Widget> items = [];

            for (final entry in groupedPredictions.entries) {
              items.add(StageHeader(stageName: entry.key));
              for (final prediction in entry.value) {
                items.add(PredictionCard(prediction: prediction));
              }
            }
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) => items[index],
            );
          } else {
            return const Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }
}
