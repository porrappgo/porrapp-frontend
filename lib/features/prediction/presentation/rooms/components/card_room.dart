import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:porrapp_frontend/features/competitions/domain/models/models.dart';
import 'package:porrapp_frontend/features/prediction/domain/models/models.dart';
import 'package:porrapp_frontend/features/prediction/presentation/room/room_page.dart';

class CardRoom extends StatelessWidget {
  final RoomUserModel roomUser;
  final CompetitionModel competition;

  const CardRoom({
    super.key,
    required this.roomUser,
    required this.competition,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Stack(
        children: [
          Positioned(
            left: -15,
            top: -15,
            child: Opacity(
              opacity: 0.06,
              child: const FadeInImage(
                width: 70,
                height: 70,
                placeholder: AssetImage('assets/images/soccer_placeholder.png'),
                image: AssetImage('assets/images/soccer_placeholder.png'),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8, left: 8),
            child: ListTile(
              title: Text(
                roomUser.room.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Competition: ${competition.name}'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                context.push('/${RoomPage.routeName}', extra: roomUser.room);
              },
            ),
          ),
        ],
      ),
    );
  }
}
