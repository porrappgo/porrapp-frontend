import 'package:flutter/material.dart';
import 'package:porrapp_frontend/features/prediction/domain/models/models.dart';
import 'package:porrapp_frontend/features/prediction/presentation/room/components/score_input.dart';

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
            Text('Match ${match.id}'),
            Text('${match.homeScore} - ${match.awayScore}'),

            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const ScoreInput(),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(':'),
                ),
                const ScoreInput(),
              ],
            ),

            const SizedBox(height: 8),

            ElevatedButton(
              onPressed: () {},
              child: const Text('Guardar predicción'),
            ),
          ],
        ),
      ),
    );
  }
}
