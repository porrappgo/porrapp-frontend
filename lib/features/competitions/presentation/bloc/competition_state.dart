import 'package:equatable/equatable.dart';
import 'package:porrapp_frontend/core/util/util.dart';

class CompetitionState extends Equatable {
  final Resource? response;

  const CompetitionState({this.response});

  CompetitionState copyWith({Resource? response}) {
    return CompetitionState(response: response ?? this.response);
  }

  @override
  List<Object?> get props => [response];
}
