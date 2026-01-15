import 'package:flutter/material.dart';
import 'package:porrapp_frontend/core/components/components.dart';
import 'package:porrapp_frontend/core/util/util.dart';
import 'package:porrapp_frontend/features/competitions/domain/models/competition_model.dart';

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
      return Padding(
        padding: EdgeInsets.all(32.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title
              Text('Create New Room'),
              const SizedBox(height: 16),

              // Room Name Input
              _roomNameTextEditor(nameController),
              const SizedBox(height: 21),

              // Competition Dropdown
              _competitionDropdown(competitions, (value) {
                selectedCompetition = value;
              }),
              const SizedBox(height: 16),

              // Create Room Button
              ButtonBase(
                text: 'Create Room',
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

InputText _roomNameTextEditor(TextEditingController nameController) {
  return InputText(
    label: 'Room Name',
    hint: 'Enter room name',
    maxLength: 50,
    onChanged: (value) {
      nameController.text = value;
    },
    validator: (value) {
      if (value == null || value.trim().isEmpty) {
        return 'Room name is required';
      }
      if (value.length < 3) {
        return 'Minimum 3 characters';
      }
      return null;
    },
  );
}

DropdownButtonFormField<CompetitionModel> _competitionDropdown(
  List<CompetitionModel> competitions,
  ValueChanged<CompetitionModel?> onChanged,
) {
  return DropdownButtonFormField<CompetitionModel>(
    decoration: InputDecorations.decoration(
      labelText: 'Competition',
      hintText: 'Select a competition',
    ),
    items: competitions.map((competition) {
      return DropdownMenuItem(
        value: competition,
        child: Text(competition.name),
      );
    }).toList(),
    validator: (value) => value == null ? 'Please select a competition' : null,
    onChanged: onChanged,
  );
}
