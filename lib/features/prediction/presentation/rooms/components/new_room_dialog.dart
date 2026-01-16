import 'package:flutter/material.dart';
import 'package:porrapp_frontend/core/components/components.dart';
import 'package:porrapp_frontend/core/util/util.dart';
import 'package:porrapp_frontend/features/competitions/domain/models/competition_model.dart';
import 'package:porrapp_frontend/l10n/app_localizations.dart';

Future<CreateRoomData?> showCreateRoomSheet(
  BuildContext context,
  List<CompetitionModel> competitions, {
  String? roomCode,
}) {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  CompetitionModel? selectedCompetition;

  return showModalBottomSheet<CreateRoomData>(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext ctx) {
      final localizations = AppLocalizations.of(context)!;

      return Padding(
        padding: EdgeInsets.all(32.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title
              Text(localizations.createNewRoomTitle),
              const SizedBox(height: 16),

              // Room Name Input
              _roomNameTextEditor(nameController, localizations),
              const SizedBox(height: 21),

              // Competition Dropdown
              _competitionDropdown(competitions, (value) {
                selectedCompetition = value;
              }, localizations),
              const SizedBox(height: 16),

              // Create Room Button
              ButtonBase(
                text: localizations.createRoom,
                onPressed: () {
                  if (!formKey.currentState!.validate()) return;

                  final createRoomData = CreateRoomData(
                    name: nameController.text,
                    competition: selectedCompetition!,
                  );
                  Navigator.of(ctx).pop(createRoomData);
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      );
    },
  );
}

InputText _roomNameTextEditor(
  TextEditingController nameController,
  AppLocalizations localizations,
) {
  return InputText(
    label: localizations.roomName,
    hint: localizations.enterRoomName,
    maxLength: 50,
    onChanged: (value) {
      nameController.text = value;
    },
    validator: (value) {
      if (value == null || value.trim().isEmpty) {
        return localizations.roomNameIsRequired;
      }
      if (value.length < 3) {
        return localizations.minimum3Characters;
      }
      return null;
    },
  );
}

DropdownButtonFormField<CompetitionModel> _competitionDropdown(
  List<CompetitionModel> competitions,
  ValueChanged<CompetitionModel?> onChanged,
  AppLocalizations localizations,
) {
  return DropdownButtonFormField<CompetitionModel>(
    decoration: InputDecorations.decoration(
      labelText: localizations.competition,
      hintText: localizations.selectACompetition,
    ),
    items: competitions.map((competition) {
      return DropdownMenuItem(
        value: competition,
        child: Text(competition.name),
      );
    }).toList(),
    validator: (value) =>
        value == null ? localizations.selectACompetition : null,
    onChanged: onChanged,
  );
}
