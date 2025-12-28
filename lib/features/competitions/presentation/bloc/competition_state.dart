import 'package:equatable/equatable.dart';
import 'package:porrapp_frontend/core/util/util.dart';

class CompetitionState extends Equatable {
  final Resource? leagues;
  final Resource? groups;
  final Resource? groupStandings;
  final Resource? teams;
  final Resource? matches;
  final Resource? logout;

  const CompetitionState({
    this.leagues,
    this.groups,
    this.groupStandings,
    this.teams,
    this.matches,
    this.logout,
  });

  CompetitionState copyWith({
    Resource? leagues,
    Resource? groups,
    Resource? groupStandings,
    Resource? teams,
    Resource? matches,
    Resource? logout,
  }) {
    return CompetitionState(
      leagues: leagues ?? this.leagues,
      groups: groups ?? this.groups,
      groupStandings: groupStandings ?? this.groupStandings,
      teams: teams ?? this.teams,
      matches: matches ?? this.matches,
      logout: logout ?? this.logout,
    );
  }

  @override
  List<Object?> get props => [
    leagues,
    groups,
    groupStandings,
    teams,
    matches,
    logout,
  ];
}
