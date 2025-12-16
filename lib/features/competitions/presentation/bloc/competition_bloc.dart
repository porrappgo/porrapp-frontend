import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:porrapp_frontend/core/util/util.dart';
import 'package:porrapp_frontend/features/competitions/domain/usecases/usecases.dart';
import 'package:porrapp_frontend/features/competitions/presentation/bloc/bloc.dart';

class CompetitionBloc extends Bloc<CompetitionEvent, CompetitionState> {
  final CompetitionUsecases competitionUsecases;

  CompetitionBloc(this.competitionUsecases) : super(const CompetitionState()) {
    on<LoadCompetitionsEvent>(_onLoadCompetitionsEvent);
  }

  void _onLoadCompetitionsEvent(
    LoadCompetitionsEvent event,
    Emitter<CompetitionState> emit,
  ) async {
    try {
      print('Loading leagues and groups...');
      emit(state.copyWith(leagues: Loading()));
      final competitions = await competitionUsecases.getCompetitions.run();
      emit(state.copyWith(leagues: competitions));

      if (competitions is Success) {
        for (var competition in competitions.data) {
          print('Fetching groups for competition ID: ${competition.id}');
          final groups = await competitionUsecases.getGroups.run(
            competition.id,
          );
          emit(state.copyWith(leagues: competitions, groups: groups));
        }
      }
    } catch (e) {
      print('Error loading leagues and groups: $e');
      emit(state.copyWith(leagues: Error('Failed to load competitions')));
    }
  }
}
