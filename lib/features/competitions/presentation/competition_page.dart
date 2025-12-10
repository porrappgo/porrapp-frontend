import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:porrapp_frontend/core/util/util.dart';
import 'package:porrapp_frontend/features/competitions/domain/models/competition_model.dart';
import 'package:porrapp_frontend/features/competitions/presentation/bloc/bloc.dart';

class CompetitionPage extends StatelessWidget {
  static const String routeName = 'competitions';

  const CompetitionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Competitions')),
      body: BlocBuilder<CompetitionBloc, CompetitionState>(
        builder: (context, state) {
          print('CompetitionState response: ${state.response}');
          if (state.response is Loading) {
            return Center(child: CircularProgressIndicator());
          } else if (state.response is Error) {
            final error = state.response as Error;
            return Center(child: Text('Error: ${error.message}'));
          } else if (state.response == null) {
            return Center(child: Text('No data available'));
          }

          return ListView.builder(
            itemCount: (state.response as Success).data.length,
            itemBuilder: (context, index) {
              final CompetitionModel competition =
                  (state.response as Success).data[index];
              return ListTile(
                title: Text(competition.name),
                subtitle: Text('Id: ${competition.id}'),
              );
            },
          );
        },
      ),
    );
  }
}
