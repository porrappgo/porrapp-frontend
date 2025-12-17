import 'package:equatable/equatable.dart';

class CompetitionEvent extends Equatable {
  const CompetitionEvent();

  @override
  List<Object> get props => [];
}

class LoadCompetitionsEvent extends CompetitionEvent {
  const LoadCompetitionsEvent();

  @override
  List<Object> get props => [];
}

class LoadMatchesEvent extends CompetitionEvent {
  const LoadMatchesEvent();

  @override
  List<Object> get props => [];
}
