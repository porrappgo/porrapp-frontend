import 'package:equatable/equatable.dart';
import 'package:porrapp_frontend/core/util/util.dart';

class CompetitionState extends Equatable {
  final Resource? leagues;
  final Resource? groups;
  final Resource? groupStandings;
  final Resource? teams;

  const CompetitionState({
    this.leagues,
    this.groups,
    this.groupStandings,
    this.teams,
  });

  CompetitionState copyWith({
    Resource? leagues,
    Resource? groups,
    Resource? groupStandings,
    Resource? teams,
  }) {
    return CompetitionState(
      leagues: leagues ?? this.leagues,
      groups: groups ?? this.groups,
      groupStandings: groupStandings ?? this.groupStandings,
      teams: teams ?? this.teams,
    );
  }

  @override
  List<Object?> get props => [leagues, groups, groupStandings];
}
