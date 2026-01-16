// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get createNewRoomTitle => 'Create New Room';

  @override
  String get competition => 'Competition';

  @override
  String get selectACompetition => 'Select a competition';

  @override
  String get roomName => 'Room Name';

  @override
  String get enterRoomName => 'Enter room name';

  @override
  String get roomNameIsRequired => 'Room name is required';

  @override
  String get minimum3Characters => 'Minimum 3 characters';

  @override
  String get createRoom => 'Create Room';

  @override
  String roomCreatedSuccessfully(Object roomName) {
    return 'Room \"$roomName\" created successfully!';
  }

  @override
  String get noRoomsAvailableYet => 'No rooms available yet.';
}
