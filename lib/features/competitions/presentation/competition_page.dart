import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import 'package:porrapp_frontend/core/util/util.dart';
import 'package:porrapp_frontend/features/auth/presentation/login_page.dart';
import 'package:porrapp_frontend/features/competitions/domain/models/models.dart';
import 'package:porrapp_frontend/features/competitions/presentation/bloc/bloc.dart';
import 'package:porrapp_frontend/features/competitions/presentation/group_standings_page.dart';
import 'package:porrapp_frontend/features/prediction/presentation/rooms/rooms_page.dart';

class CompetitionPage extends StatelessWidget {
  static const String routeName = 'competitions';

  const CompetitionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CompetitionBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Competitions'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              bloc.add(LogoutEvent());
            },
          ),
        ],
      ),
      body: BlocListener<CompetitionBloc, CompetitionState>(
        listener: (context, state) {
          if (state.logout is Success && (state.logout as Success).data) {
            // Navigate to login page on successful logout
            context.go('/${LoginPage.routeName}');
          } else if (state.logout is Error) {
            final error = state.logout as Error;
            Fluttertoast.showToast(
              msg: 'Logout failed: ${error.message}',
              toastLength: Toast.LENGTH_LONG,
            );
          }
        },
        child: BlocBuilder<CompetitionBloc, CompetitionState>(
          builder: (context, state) {
            print('CompetitionState response: ${state.leagues}');
            print('CompetitionState response: ${state.logout}');

            if (state.leagues is Loading) {
              return Center(child: CircularProgressIndicator());
            } else if (state.leagues is Error) {
              final error = state.leagues as Error;
              return Center(child: Text('Error: ${error.message}'));
            } else if (state.leagues == null) {
              return Center(child: Text('No data available'));
            }

            // List of competitions loaded successfully and floating action button to navigate to rooms page.
            return Stack(
              children: [
                ListView.builder(
                  itemCount: (state.leagues as Success).data.length,
                  itemBuilder: (context, index) {
                    final CompetitionModel competition =
                        (state.leagues as Success).data[index];
                    return ListTile(
                      title: Text("${competition.name} - ${competition.year}"),
                      subtitle: Text('Id: ${competition.id}'),
                      leading: competition.logo != null
                          ? CachedNetworkImage(
                              imageUrl: competition.logo!,
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            )
                          : null,
                      onTap: () {
                        if (state.groups == null ||
                            state.groups is! Success ||
                            (state.groups as Success).data.isEmpty) {
                          Fluttertoast.showToast(
                            msg: 'Group data not available',
                            toastLength: Toast.LENGTH_LONG,
                          );
                          return;
                        }

                        final CompetitionsModel competitionsModel =
                            CompetitionsModel(
                              competion: competition,
                              groups: (state.groups as Success).data,
                              groupStandings:
                                  (state.groupStandings as Success).data,
                              teams: (state.teams as Success).data,
                            );

                        context.push(
                          '/${GroupStandingsPage.routeName}',
                          extra: competitionsModel,
                        );
                      },
                    );
                  },
                ),

                Container(
                  padding: EdgeInsets.all(16.0),
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    onPressed: () {
                      context.push(
                        '/${RoomsPage.routeName}',
                        extra: (state.leagues as Success).data[0].id,
                      );
                    },
                    child: Icon(Icons.meeting_room),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
