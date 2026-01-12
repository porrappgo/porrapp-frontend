import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:porrapp_frontend/features/prediction/domain/models/models.dart';
import 'package:porrapp_frontend/features/prediction/presentation/room/bloc/room_bloc.dart';
import 'package:porrapp_frontend/features/prediction/presentation/room/components/score_input.dart';
import 'package:porrapp_frontend/features/prediction/presentation/room/components/team_info.dart';

class PredictionCard extends StatefulWidget {
  final PredictionModel prediction;

  const PredictionCard({super.key, required this.prediction});

  @override
  State<PredictionCard> createState() => _PredictionCardState();
}

class _PredictionCardState extends State<PredictionCard> {
  late TextEditingController homeController;
  late TextEditingController awayController;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    homeController = TextEditingController(
      text: widget.prediction.predictedHomeScore.toString(),
    );
    awayController = TextEditingController(
      text: widget.prediction.predictedAwayScore.toString(),
    );
  }

  void _onChanged() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      context.read<RoomBloc>().add(
        UpdatePredictionLocally(
          predictionId: widget.prediction.id,
          homeScore: int.tryParse(homeController.text),
          awayScore: int.tryParse(awayController.text),
        ),
      );
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    homeController.dispose();
    awayController.dispose();
    super.dispose();
  }

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
                // Home team
                TeamInfo(
                  teamName: match.homeTeam.name,
                  teamLogoUrl: match.homeTeam.flag,
                ),
                const SizedBox(width: 21),
                ScoreInput(
                  controller: homeController,
                  onChanged: (_) => _onChanged(),
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(':'),
                ),

                // Away team
                ScoreInput(
                  controller: awayController,
                  onChanged: (_) => _onChanged(),
                ),

                const SizedBox(width: 21),
                TeamInfo(
                  teamName: match.awayTeam.name,
                  teamLogoUrl: match.awayTeam.flag,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
