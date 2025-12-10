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
      print('Loading competitions...');
      emit(state.copyWith(response: Loading()));
      final competitions = await competitionUsecases.getCompetitions.run();
      emit(state.copyWith(response: competitions));
    } catch (e) {
      print('Error loading competitions: $e');
      emit(state.copyWith(response: Error('Failed to load competitions')));
    }
  }
}
