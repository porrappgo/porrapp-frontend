import 'package:flutter/material.dart';

import 'package:porrapp_frontend/core/components/components.dart';
import 'package:porrapp_frontend/core/util/util.dart';
import 'package:porrapp_frontend/features/competitions/domain/models/competition_model.dart';
import 'package:porrapp_frontend/l10n/app_localizations.dart';

Future<dynamic> showCreateRoomSheet(
  BuildContext context,
  List<CompetitionModel> competitions, {
  String? roomCode,
}) {
  return showModalBottomSheet<dynamic>(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext ctx) {
      final localizations = AppLocalizations.of(context)!;

      return Padding(
        padding: EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Create Room Section
            _createRoom(context, localizations, competitions),
            // Inside in Room Section
            _insideInRoom(context, localizations),
            const SizedBox(height: 16),
          ],
        ),
      );
    },
  );
}

Widget _createRoom(
  BuildContext context,
  AppLocalizations localizations,
  List<CompetitionModel> competitions,
) {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  //CompetitionModel? selectedCompetition;

  return Form(
    key: formKey,
    child: Column(
      children: [
        // Title
        Text(localizations.createNewRoomTitle),
        const SizedBox(height: 16),

        // Room Name Input
        _roomTextEditor(
          nameController,
          localizations,
          localizations.roomName,
          localizations.enterRoomName,
          50,
        ),

        // // Competition Dropdown
        // const SizedBox(height: 21),
        // _competitionDropdown(competitions, (value) {
        //   selectedCompetition = value;
        // }, localizations),
        // const SizedBox(height: 16),

        // Create Room Button
        ButtonBase(
          text: localizations.createRoom,
          onPressed: () {
            if (!formKey.currentState!.validate()) return;

            final createRoomData = CreateRoomData(
              name: nameController.text,
              competition: competitions.first,
            );
            Navigator.of(context).pop(createRoomData);
          },
        ),
      ],
    ),
  );
}

Widget _insideInRoom(BuildContext context, AppLocalizations localizations) {
  final formKey = GlobalKey<FormState>();
  final TextEditingController roomCodeController = TextEditingController();
  //CompetitionModel? selectedCompetition;

  return Form(
    key: formKey,
    child: Column(
      children: [
        // Line separator section
        const SizedBox(height: 32),
        Divider(color: Theme.of(context).colorScheme.onSurface, thickness: 1),
        const Text('OR'),
        const SizedBox(height: 32),

        // Room Code Input
        _roomTextEditor(
          roomCodeController,
          localizations,
          localizations.roomCode,
          localizations.enterRoomCode,
          6,
        ),

        // Join in room Button
        ButtonBase(
          text: localizations.insideInRoom,
          onPressed: () {
            if (!formKey.currentState!.validate()) return;
            Navigator.of(context).pop(roomCodeController.text);
          },
        ),
      ],
    ),
  );
}

InputText _roomTextEditor(
  TextEditingController nameController,
  AppLocalizations localizations,
  String label,
  String hint,
  int maxLength,
) {
  return InputText(
    label: label,
    hint: hint,
    maxLength: maxLength,
    onChanged: (value) {
      nameController.text = value;
    },
    validator: (value) {
      if (value == null || value.trim().isEmpty) {
        return localizations.fieldIsRequired;
      }
      if (value.length < 3) {
        return localizations.minimum3Characters;
      }
      return null;
    },
  );
}

// DropdownButtonFormField<CompetitionModel> _competitionDropdown(
//   List<CompetitionModel> competitions,
//   ValueChanged<CompetitionModel?> onChanged,
//   AppLocalizations localizations,
// ) {
//   return DropdownButtonFormField<CompetitionModel>(
//     decoration: InputDecorations.decoration(
//       labelText: localizations.competition,
//       hintText: localizations.selectACompetition,
//     ),
//     items: competitions.map((competition) {
//       return DropdownMenuItem(
//         value: competition,
//         child: Text(competition.name),
//       );
//     }).toList(),
//     validator: (value) =>
//         value == null ? localizations.selectACompetition : null,
//     onChanged: onChanged,
//   );
// }
