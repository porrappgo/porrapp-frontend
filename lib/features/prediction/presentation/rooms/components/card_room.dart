import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:porrapp_frontend/features/competitions/domain/models/models.dart';
import 'package:porrapp_frontend/features/prediction/domain/models/models.dart';
import 'package:porrapp_frontend/features/prediction/presentation/room/room_page.dart';
import 'package:porrapp_frontend/l10n/app_localizations.dart';

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
    final localizations = AppLocalizations.of(context)!;
    final defaultImage = Theme.of(context).brightness == Brightness.dark
        ? AssetImage('assets/images/light_soccer_placeholder.png')
        : AssetImage('assets/images/soccer_placeholder.png');

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Stack(
        children: [
          Positioned(
            left: -15,
            top: -15,
            child: Opacity(
              opacity: Theme.of(context).brightness == Brightness.dark
                  ? 0.1
                  : 0.06,
              // Display icon by theme type
              child: FadeInImage(
                width: 70,
                height: 70,
                placeholder: defaultImage,
                image: defaultImage,
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
              subtitle: Text(
                '${localizations.competition}: ${competition.name}',
              ),
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
