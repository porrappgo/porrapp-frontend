import 'package:flutter/material.dart';
import 'package:porrapp_frontend/features/competitions/domain/models/models.dart';

class MatchesPage extends StatefulWidget {
  static const String routeName = 'matches';

  final CompetitionsModel competitions;

  const MatchesPage({super.key, required this.competitions});

  @override
  State<MatchesPage> createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage> {
  @override
  void initState() {
    super.initState();
    // You can initiate data fetching or other setup here if needed.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Matches')),
      body: Center(
        child: Text('Matches Page for ${widget.competitions.competion.name}'),
      ),
    );
  }
}
