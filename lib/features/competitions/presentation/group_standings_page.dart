import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:porrapp_frontend/features/competitions/domain/models/models.dart';
import 'package:porrapp_frontend/features/competitions/presentation/matches_page.dart';

class GroupStandingsPage extends StatelessWidget {
  static const String routeName = 'group_standings';

  final CompetitionsModel competitions;

  const GroupStandingsPage({super.key, required this.competitions});

  @override
  Widget build(BuildContext context) {
    // Display grops and standings to display of teams and flags in items of a list.
    return Scaffold(
      // Appbar with navigate to matches page.
      appBar: AppBar(
        title: const Text('Group Standings'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sports_soccer),
            onPressed: () {
              context.push('/${MatchesPage.routeName}', extra: competitions);
            },
          ),
        ],
      ),
      body: Center(
        child: ListView.builder(
          itemCount: competitions.groups.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    competitions.groups[index].name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        _headerRow(),
                        const Divider(color: Colors.white24),

                        ...competitions.groupStandings
                            .where(
                              (gs) => gs.group == competitions.groups[index].id,
                            )
                            .map((gs) {
                              final team = competitions.teams.firstWhere(
                                (t) => t.id == gs.team,
                              );
                              return _teamRow(team, gs.position, gs.points);
                            }),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

Widget _headerRow() {
  return Row(
    children: const [
      SizedBox(width: 24, child: Text('#', style: _headerStyle)),
      Expanded(child: Text('Teams', style: _headerStyle)),
      Text('MP', style: _headerStyle),
      SizedBox(width: 16),
      Text('+/-', style: _headerStyle),
      SizedBox(width: 16),
      Text('Pts', style: _headerStyle),
    ],
  );
}

Widget _teamRow(TeamModel team, int position, int points) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        SizedBox(width: 24, child: Text(position.toString(), style: _rowStyle)),

        Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            image: DecorationImage(
              image: CachedNetworkImageProvider(team.flag!),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 8),

        Expanded(child: Text(team.name, style: _rowStyle)),

        const Text('-', style: _rowStyle),
        const SizedBox(width: 16),
        const Text('-', style: _rowStyle),
        const SizedBox(width: 16),
        Text(points.toString(), style: _rowStyle),
      ],
    ),
  );
}

const _headerStyle = TextStyle(fontWeight: FontWeight.w600);

const _rowStyle = TextStyle(fontSize: 14);
