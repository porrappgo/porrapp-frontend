import 'package:equatable/equatable.dart';
import 'package:porrapp_frontend/core/util/util.dart';

class RoomState extends Equatable {
  final Resource? room;

  const RoomState({this.room});

  RoomState copyWith({Resource? room}) {
    return RoomState(room: room ?? this.room);
  }

  @override
  List<Object?> get props => [room];
}
