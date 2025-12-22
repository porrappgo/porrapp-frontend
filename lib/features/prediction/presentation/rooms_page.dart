import 'package:flutter/material.dart';

class RoomsPage extends StatelessWidget {
  static const String routeName = 'rooms';

  const RoomsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rooms')),
      body: const Center(child: Text('Rooms Page Content Here')),
    );
  }
}
