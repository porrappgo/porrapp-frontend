import 'package:flutter/material.dart';

class RoomsNoYet extends StatelessWidget {
  const RoomsNoYet({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Icon(Icons.meeting_room, size: 100, color: Colors.grey),
          SizedBox(height: 20),
          Text('No rooms available yet.'),
        ],
      ),
    );
  }
}
