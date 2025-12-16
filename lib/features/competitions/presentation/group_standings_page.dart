import 'package:flutter/material.dart';
import 'package:porrapp_frontend/features/competitions/domain/models/models.dart';

class GroupStandingsPage extends StatelessWidget {
  static const String routeName = 'group_standings';

  final List<GroupModel> group;

  const GroupStandingsPage({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Group Standings')),
      body: Center(
        child: ListView.builder(
          itemCount: group.length,
          itemBuilder: (context, index) {
            final GroupModel grp = group[index];
            return ListTile(title: Text('Group: ${grp.name}'));
          },
        ),
      ),
    );
  }
}
