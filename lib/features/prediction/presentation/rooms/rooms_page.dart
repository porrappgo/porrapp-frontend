import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:porrapp_frontend/core/components/components.dart';
import 'package:porrapp_frontend/features/auth/presentation/login_page.dart';
import 'package:porrapp_frontend/features/competitions/domain/models/models.dart';

import 'package:porrapp_frontend/features/prediction/domain/models/models.dart';
import 'package:porrapp_frontend/features/prediction/presentation/rooms/bloc/rooms_bloc.dart';
import 'package:porrapp_frontend/features/prediction/presentation/rooms/components/card_room.dart';
import 'package:porrapp_frontend/features/prediction/presentation/rooms/components/new_room_dialog.dart';
import 'package:porrapp_frontend/features/prediction/presentation/rooms/components/rooms_no_yet.dart';
import 'package:porrapp_frontend/l10n/app_localizations.dart';

class RoomsPage extends StatefulWidget {
  static const String tag = 'RoomsPage';
  static const String routeName = 'rooms';

  final String? codeRoom;

  const RoomsPage({super.key, this.codeRoom});

  @override
  State<RoomsPage> createState() => _RoomsPageState();
}

class _RoomsPageState extends State<RoomsPage> {
  @override
  void initState() {
    super.initState();
    context.read<RoomsBloc>().add(const LoadRoomsEvent());
  }

  @override
  Widget build(BuildContext context) {
    final roomsBloc = BlocProvider.of<RoomsBloc>(context);
    final localizations = AppLocalizations.of(context)!;

    return BlocListener<RoomsBloc, RoomsState>(
      listener: (context, state) async {
        FlutterLogs.logInfo(
          RoomsPage.tag,
          'listener',
          'RoomsState changed to: ${state.runtimeType}',
        );

        if (state is RoomsError) {
          Fluttertoast.showToast(
            msg: state.message,
            toastLength: Toast.LENGTH_LONG,
          );
        }

        if (state is LogoutError) {
          Fluttertoast.showToast(
            msg: state.message,
            toastLength: Toast.LENGTH_LONG,
          );
        }

        if (state is RoomsCreated) {
          Fluttertoast.showToast(
            msg: localizations.roomCreatedSuccessfully(state.room.name),
            toastLength: Toast.LENGTH_LONG,
          );
          // Reload rooms after creating a new one
          roomsBloc.add(const LoadRoomsEvent());
        }

        if (state is RoomsHasData) {
          if (widget.codeRoom == null || widget.codeRoom!.isEmpty) return;
          await _displayCreateRoomDialog(
            context,
            state,
            roomsBloc,
            roomCode: widget.codeRoom,
          );
        }

        if (state is LogoutSuccess) {
          Fluttertoast.showToast(
            msg: "Logged out successfully",
            toastLength: Toast.LENGTH_LONG,
          );
          roomsBloc.add(const ResetRoomsEvent());
          context.go('/${LoginPage.routeName}');
        }
      },
      child: BlocBuilder<RoomsBloc, RoomsState>(
        builder: (context, state) {
          FlutterLogs.logInfo(
            RoomsPage.tag,
            'build',
            'Current RoomsState: ${state.runtimeType}',
          );

          // Display loading indicator while rooms are being loaded
          if (state is RoomsLoading || state is LogoutLoading) {
            return const CircularLoadingPage();
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

            return Scaffold(
              appBar: AppBar(
                title: Text('PorrApp ${widget.codeRoom ?? ''}'),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.logout),
                    onPressed: () {
                      roomsBloc.add(LogoutFromAppEvent());
                    },
                  ),
                ],
              ),
              body: Stack(
                children: [
                  if (rooms.isEmpty)
                    const RoomsNoYet()
                  else
                    _roomsList(rooms, state.competitions),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  await _displayCreateRoomDialog(context, state, roomsBloc);
                },
                child: const Icon(Icons.add),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

Future<void> _displayCreateRoomDialog(
  BuildContext context,
  RoomsHasData state,
  RoomsBloc roomsBloc, {
  String? roomCode,
}) async {
  final result = await showCreateRoomSheet(
    context,
    state.competitions,
    roomCode: roomCode,
  );

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
