import 'package:flutter/material.dart';
import 'package:porrapp_frontend/l10n/app_localizations.dart';

class RoomsNoYet extends StatelessWidget {
  const RoomsNoYet({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.meeting_room, size: 100, color: Colors.grey),
          const SizedBox(height: 20),
          Text(localizations.noRoomsAvailableYet),
        ],
      ),
    );
  }
}
