import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:porrapp_frontend/core/util/util.dart';
import 'package:porrapp_frontend/features/prediction/domain/models/models.dart';
import 'package:porrapp_frontend/features/prediction/presentation/room/bloc/room_bloc.dart';
import 'package:porrapp_frontend/features/prediction/presentation/room/components/prediction_card.dart';
import 'package:porrapp_frontend/features/prediction/presentation/room/components/stage_header.dart';

class RoomPage extends StatefulWidget {
  static const String routeName = 'room';

  final int roomId;
  final String? roomName;
  final String? deeplink;

  const RoomPage({
    super.key,
    required this.roomId,
    this.roomName,
    this.deeplink,
  });

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
      appBar: AppBar(
        title: Text(widget.roomName ?? 'Room Page'),
        actions: [
          // Display list of rankings of scores of users in this room.
          // Simple dialog
          IconButton(
            icon: const Icon(Icons.leaderboard),
            onPressed: () {
              _rankingUser(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.person_add_outlined),
            onPressed: () async {
              if (widget.deeplink == null) return;

              await showShareDialog(
                text: 'Join my prediction room using this link:',
                uri: Uri.parse(widget.deeplink!),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<RoomBloc, RoomState>(
        builder: (context, state) {
          if (state is RoomLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RoomError) {
            return Center(child: Text(state.message));
          } else if (state is RoomHasData) {
            // print(
            //   'hasChanges: ${state.hasChanges}, isSaving: ${state.isSaving}',
            // );
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
      floatingActionButton: floatingAcctionButton(),
    );
  }

  Future<dynamic> _rankingUser(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Rankings'),
          content: SizedBox(
            width: double.maxFinite,
            child: BlocBuilder<RoomBloc, RoomState>(
              builder: (context, state) {
                if (state is RoomHasData) {
                  final rankings = state.roomUsers;
                  if (rankings != null && rankings.isNotEmpty) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: rankings.length,
                      itemBuilder: (context, index) {
                        final ranking = rankings[index];
                        return ListTile(
                          leading: Text('#${index + 1}'),
                          title: Text(ranking.user?.name ?? 'Unknown'),
                          trailing: Text('${ranking.totalPoints} pts'),
                        );
                      },
                    );
                  }
                  return const Text('No rankings available.');
                } else {
                  return const Text('No rankings available.');
                }
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  BlocConsumer<RoomBloc, RoomState> floatingAcctionButton() {
    return BlocConsumer<RoomBloc, RoomState>(
      listener: (context, state) {
        if (state is RoomHasData && state.errorMessage != null) {
          // print(
          //   'hasChanges: ${state.hasChanges}, isSaving: ${state.isSaving}',
          // );
          Fluttertoast.showToast(
            msg: state.errorMessage!,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
        }
      },
      builder: (context, state) {
        if (state is RoomHasData) {
          print('hasChanges: ${state.hasChanges}, isSaving: ${state.isSaving}');
          return FloatingActionButton.extended(
            onPressed: (!state.hasChanges || state.isSaving)
                ? null
                : () => context.read<RoomBloc>().add(SavePredictions()),
            icon: const Icon(Icons.save),
            label: state.isSaving
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Save'),
          );
        }
        return const SizedBox();
      },
    );
  }
}
