import 'package:flutter/material.dart';
import 'package:porrapp_frontend/core/components/button_base.dart';
import 'package:porrapp_frontend/core/components/input_text.dart';
import 'package:porrapp_frontend/core/util/util.dart';
import 'package:porrapp_frontend/features/competitions/domain/models/competition_model.dart';

Future<CreateRoomData?> showCreateRoomSheet(
  BuildContext context,
  // List<CompetitionModel>? competitions,
) {
  final TextEditingController nameController = TextEditingController();
  CompetitionModel? selectedCompetition;

  return showModalBottomSheet<CreateRoomData>(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext ctx) {
      return Padding(
        padding: EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Create New Room'),
            const SizedBox(height: 16),
            InputText(
              label: 'Room Name',
              hint: 'Enter room name',
              onChanged: (value) {},
            ),
            const SizedBox(height: 16),
            // DropdownButton<CompetitionModel>(
            //   hint: const Text('Select Competition'),
            //   value: selectedCompetition,
            //   isExpanded: true,
            //   items: competitions?.map((CompetitionModel competition) {
            //     return DropdownMenuItem<CompetitionModel>(
            //       value: competition,
            //       child: Text(competition.name),
            //     );
            //   }).toList(),
            //   onChanged: (CompetitionModel? newValue) {
            //     selectedCompetition = newValue;
            //   },
            // ),
            const SizedBox(height: 16),
            ButtonBase(
              text: 'Create Room',
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    selectedCompetition != null) {
                  final createRoomData = CreateRoomData(
                    name: nameController.text,
                    competition: selectedCompetition!,
                  );
                  Navigator.of(ctx).pop(createRoomData);
                }
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      );
    },
  );
}
