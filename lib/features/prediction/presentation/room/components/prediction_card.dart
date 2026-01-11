import 'package:flutter/material.dart';
import 'package:porrapp_frontend/features/prediction/domain/models/models.dart';
import 'package:porrapp_frontend/features/prediction/presentation/room/components/score_input.dart';
import 'package:porrapp_frontend/features/prediction/presentation/room/components/team_info.dart';

class PredictionCard extends StatefulWidget {
  final PredictionModel prediction;

  const PredictionCard({super.key, required this.prediction});

  @override
  State<PredictionCard> createState() => _PredictionCardState();
}

class _PredictionCardState extends State<PredictionCard> {
  @override
  Widget build(BuildContext context) {
    final match = widget.prediction.match;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text('Match ${match.id} - ${match.date.toLocal()}'),
            match.isFinished
                ? const Text(
                    'Match Finished',
                    style: TextStyle(color: Colors.red),
                  )
                : const SizedBox.shrink(),

            Text('${match.homeScore} - ${match.awayScore}'),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TeamInfo(
                  teamName: match.homeTeam.name,
                  teamLogoUrl: match.homeTeam.flag,
                ),
                const SizedBox(width: 21),
                const ScoreInput(),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(':'),
                ),
                const ScoreInput(),

                const SizedBox(width: 21),
                TeamInfo(
                  teamName: match.awayTeam.name,
                  teamLogoUrl: match.awayTeam.flag,
                ),
              ],
            ),

            // const SizedBox(height: 8),

            // ElevatedButton(
            //   onPressed: () {},
            //   child: const Text('Guardar predicción'),
            // ),
          ],
        ),
      ),
    );
  }
}
