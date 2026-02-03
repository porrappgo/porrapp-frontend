import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:porrapp_frontend/core/util/util.dart';
import 'package:porrapp_frontend/features/prediction/domain/models/models.dart';
import 'package:porrapp_frontend/features/prediction/presentation/room/bloc/room_bloc.dart';
import 'package:porrapp_frontend/features/prediction/presentation/room/components/prediction_card.dart';
import 'package:porrapp_frontend/features/prediction/presentation/room/components/stage_header.dart';
import 'package:porrapp_frontend/l10n/app_localizations.dart';

enum Menu { rankings, invite, deleteRoom, leaveRoom }

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
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.roomName ?? 'Room Page'),
        actions: [
          PopupMenuButton<Menu>(
            onSelected: (Menu value) {
              _itemMenuButtonSelected(context, value, localizations);
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: Menu.rankings,
                child: ListTile(
                  leading: Icon(Icons.leaderboard),
                  title: Text('Rankings'),
                ),
              ),
              PopupMenuItem(
                value: Menu.invite,
                child: ListTile(
                  leading: Icon(Icons.person_add_outlined),
                  title: Text('Invite'),
                ),
              ),
              PopupMenuItem(
                value: Menu.deleteRoom,
                child: ListTile(
                  leading: Icon(Icons.delete),
                  title: Text('Delete Room'),
                ),
              ),
              const PopupMenuDivider(),
              PopupMenuItem(
                value: Menu.leaveRoom,
                child: ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text('Leave Room'),
                ),
              ),
            ],
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
      floatingActionButton: floatingActionButton(localizations),
    );
  }

  void _itemMenuButtonSelected(
    BuildContext context,
    Menu value,
    AppLocalizations localizations,
  ) async {
    switch (value) {
      case Menu.rankings:
        _rankingUser(context, localizations);
        break;
      case Menu.invite:
        if (widget.deeplink == null) return;

        await showShareDialog(
          text: localizations.joinMyPredictionRoomUsingThisLink,
          uri: Uri.parse(widget.deeplink!),
        );
        break;
      case Menu.deleteRoom:
        Fluttertoast.showToast(
          msg: "Delete room not implemented yet.",
          toastLength: Toast.LENGTH_LONG,
        );
        break;
      case Menu.leaveRoom:
        Fluttertoast.showToast(
          msg: "Leave room not implemented yet.",
          toastLength: Toast.LENGTH_LONG,
        );
        break;
    }
  }

  Future<dynamic> _rankingUser(
    BuildContext context,
    AppLocalizations localizations,
  ) {
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
              child: Text(localizations.cancelButton),
            ),
          ],
        );
      },
    );
  }

  BlocConsumer<RoomBloc, RoomState> floatingActionButton(
    AppLocalizations localizations,
  ) {
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
          return FloatingActionButton.extended(
            onPressed: (!state.hasChanges || state.isSaving)
                ? null
                : () => _savePredictions(context, localizations),
            icon: const Icon(Icons.save),
            label: state.isSaving
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(localizations.saveText),
          );
        }
        return const SizedBox();
      },
    );
  }

  void _savePredictions(BuildContext context, AppLocalizations localizations) {
    messageDialog(
      context: context,
      title: localizations.confirmSaveTitle,
      content: localizations.confirmSaveContent,
      onConfirmed: () {
        context.read<RoomBloc>().add(SavePredictionsEvent());
      },
    );
  }
}
