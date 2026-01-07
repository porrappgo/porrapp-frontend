import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:porrapp_frontend/features/competitions/domain/models/models.dart';
import 'package:porrapp_frontend/features/competitions/presentation/bloc/competition_bloc.dart';

class MatchesPage extends StatefulWidget {
  static const String routeName = 'matches';

  final CompetitionsModel competitions;

  const MatchesPage({super.key, required this.competitions});

  @override
  State<MatchesPage> createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage> {
  @override
  void initState() {
    super.initState();
    print('MatchesPage initialized, loading matches...');
    context.read<CompetitionBloc>().add(LoadMatchesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Matches')),
      body: BlocBuilder<CompetitionBloc, CompetitionState>(
        builder: (context, state) {
          // print('Building MatchesPage with state: ${state.matches}');
          // if (state.matches is Loading) {
          //   return const Center(child: CircularProgressIndicator());
          // }

          // if (state.matches is Error) {
          //   return Center(child: Text('Error: ${state.matches}'));
          // }

          // if (state.matches is Success<List<MatchModel>>) {
          //   final matches = (state.matches as Success<List<MatchModel>>).data;
          //   final teams = widget.competitions.teams;
          //   return ListView.builder(
          //     itemCount: matches.length,
          //     itemBuilder: (context, index) {
          //       final match = matches[index];
          //       final homeTeam = teams.firstWhere(
          //         (team) => team.id == match.homeTeam,
          //       );
          //       final awayTeam = teams.firstWhere(
          //         (team) => team.id == match.awayTeam,
          //       );
          //       // Container to display team information and result of the match game.
          //       return Container(
          //         margin: const EdgeInsets.all(8.0),
          //         padding: const EdgeInsets.all(16.0),
          //         decoration: BoxDecoration(
          //           color: Colors.white,
          //           borderRadius: BorderRadius.circular(8.0),
          //           boxShadow: [
          //             BoxShadow(
          //               color: Colors.grey.withOpacity(0.3),
          //               blurRadius: 5,
          //               offset: const Offset(0, 3),
          //             ),
          //           ],
          //         ),
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               children: [
          //                 Row(
          //                   // Flag and country name
          //                   children: [
          //                     Container(
          //                       width: 26,
          //                       height: 26,
          //                       decoration: BoxDecoration(
          //                         shape: BoxShape.circle,
          //                         color: Colors.white,
          //                         image: DecorationImage(
          //                           image: CachedNetworkImageProvider(
          //                             homeTeam.flag!,
          //                           ),
          //                           fit: BoxFit.cover,
          //                         ),
          //                       ),
          //                     ),
          //                     const SizedBox(width: 8.0),
          //                     Text(
          //                       homeTeam.name,
          //                       style: const TextStyle(fontSize: 16),
          //                     ),
          //                   ],
          //                 ),
          //                 Text(
          //                   '${match.homeScore} - ${match.awayScore}',
          //                   style: const TextStyle(
          //                     fontSize: 18,
          //                     fontWeight: FontWeight.bold,
          //                   ),
          //                 ),
          //                 Row(
          //                   // Flag and country name
          //                   children: [
          //                     Text(
          //                       awayTeam.name,
          //                       style: const TextStyle(fontSize: 16),
          //                     ),
          //                     const SizedBox(width: 8.0),
          //                     Container(
          //                       width: 26,
          //                       height: 26,
          //                       decoration: BoxDecoration(
          //                         shape: BoxShape.circle,
          //                         color: Colors.white,
          //                         image: DecorationImage(
          //                           image: CachedNetworkImageProvider(
          //                             awayTeam.flag!,
          //                           ),
          //                           fit: BoxFit.cover,
          //                         ),
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               ],
          //             ),

          //             const SizedBox(height: 4.0),
          //             Text(
          //               'Date: ${match.date}',
          //               style: const TextStyle(
          //                 fontSize: 14,
          //                 color: Colors.grey,
          //               ),
          //             ),
          //           ],
          //         ),
          //       );
          //     },
          //   );
          // }

          return const SizedBox();
        },
      ),
    );
  }
}
