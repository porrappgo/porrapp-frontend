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

  @override
  String get loginTitle => 'Welcome Back';

  @override
  String get emailLabel => 'Email';

  @override
  String get emailHint => 'Enter your email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get passwordHint => 'Enter your password';

  @override
  String get dontHaveAccountRegister => 'Don\'t have an account? Register';

  @override
  String get loginButton => 'Login';

  @override
  String get nameLabel => 'Name';

  @override
  String get nameHint => 'Enter your name';

  @override
  String get confirmPasswordLabel => 'Confirm Password';

  @override
  String get confirmPasswordHint => 'Enter your password again';

  @override
  String get registerButton => 'Register';

  @override
  String get alreadyHaveAccountLogin => 'Already have an account? Login';

  @override
  String get roomCode => 'Room Code';

  @override
  String get enterRoomCode => 'Enter room code';

  @override
  String get fieldIsRequired => 'This field is required';

  @override
  String get insideInRoom => 'Join Room';

  @override
  String get confirmSaveTitle => 'Confirm Save';

  @override
  String get confirmSaveContent =>
      'Are you sure you want to save your predictions?, you won\'t be able to change them later.';

  @override
  String get confirmButton => 'Confirm';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get saveText => 'Save';

  @override
  String get joinMyPredictionRoomUsingThisLink =>
      'Join my prediction room using this link:';

  @override
  String get leaveRoom => 'Leave Room';

  @override
  String get leaveRoomConfirmation =>
      'Are you sure you want to leave the room?';
}
