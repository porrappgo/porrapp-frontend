part of 'competition_bloc.dart';

class CompetitionState extends Equatable {
  const CompetitionState();

  @override
  List<Object> get props => [];
}

final class CompetitionLoading extends CompetitionState {}

final class CompetitionError extends CompetitionState {
  final String message;

  const CompetitionError(this.message);

  @override
  List<Object> get props => [message];
}

final class CompetitionHasData extends CompetitionState {
  final List<CompetitionModel> competitions;

  const CompetitionHasData(this.competitions);

  @override
  List<Object> get props => [competitions];
}
