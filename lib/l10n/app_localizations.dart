import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// Title for the create new room dialog
  ///
  /// In en, this message translates to:
  /// **'Create New Room'**
  String get createNewRoomTitle;

  /// Label for the competition dropdown in the create new room dialog
  ///
  /// In en, this message translates to:
  /// **'Competition'**
  String get competition;

  /// Hint text for the competition dropdown in the create new room dialog
  ///
  /// In en, this message translates to:
  /// **'Select a competition'**
  String get selectACompetition;

  /// Label for the room name input field in the create new room dialog
  ///
  /// In en, this message translates to:
  /// **'Room Name'**
  String get roomName;

  /// Hint text for the room name input field in the create new room dialog
  ///
  /// In en, this message translates to:
  /// **'Enter room name'**
  String get enterRoomName;

  /// Validation message when the room name is not provided
  ///
  /// In en, this message translates to:
  /// **'Room name is required'**
  String get roomNameIsRequired;

  /// Validation message when the room name is less than 3 characters
  ///
  /// In en, this message translates to:
  /// **'Minimum 3 characters'**
  String get minimum3Characters;

  /// Text for the create room button in the create new room dialog
  ///
  /// In en, this message translates to:
  /// **'Create Room'**
  String get createRoom;

  /// Toast message shown when a room is created successfully
  ///
  /// In en, this message translates to:
  /// **'Room \"{roomName}\" created successfully!'**
  String roomCreatedSuccessfully(Object roomName);

  /// Message shown when there are no rooms available
  ///
  /// In en, this message translates to:
  /// **'No rooms available yet.'**
  String get noRoomsAvailableYet;

  /// Title for the login screen
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get loginTitle;

  /// Label for the email input field on the login screen
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// Hint text for the email input field on the login screen
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get emailHint;

  /// Label for the password input field on the login screen
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// Hint text for the password input field on the login screen
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get passwordHint;

  /// Text for the link to the registration page on the login screen
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? Register'**
  String get dontHaveAccountRegister;

  /// Text for the login button on the login screen
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginButton;

  /// Label for the name input field on the registration screen
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get nameLabel;

  /// Hint text for the name input field on the registration screen
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get nameHint;

  /// Label for the confirm password input field on the registration screen
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPasswordLabel;

  /// Hint text for the confirm password input field on the registration screen
  ///
  /// In en, this message translates to:
  /// **'Enter your password again'**
  String get confirmPasswordHint;

  /// Text for the register button on the registration screen
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get registerButton;

  /// Text for the link to the login page on the registration screen
  ///
  /// In en, this message translates to:
  /// **'Already have an account? Login'**
  String get alreadyHaveAccountLogin;

  /// Label for the room code input field in the join room dialog
  ///
  /// In en, this message translates to:
  /// **'Room Code'**
  String get roomCode;

  /// Hint text for the room code input field in the join room dialog
  ///
  /// In en, this message translates to:
  /// **'Enter room code'**
  String get enterRoomCode;

  /// Validation message when a required field is not provided
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get fieldIsRequired;

  /// Text for the join room button in the join room dialog
  ///
  /// In en, this message translates to:
  /// **'Join Room'**
  String get insideInRoom;

  /// Title for the confirm save dialog
  ///
  /// In en, this message translates to:
  /// **'Confirm Save'**
  String get confirmSaveTitle;

  /// Content for the confirm save dialog
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to save your predictions?, you won\'t be able to change them later.'**
  String get confirmSaveContent;

  /// Text for the confirm button in dialogs
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirmButton;

  /// Text for the cancel button in dialogs
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButton;

  /// Text for the save button
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveText;

  /// Text for sharing the prediction room link
  ///
  /// In en, this message translates to:
  /// **'Join my prediction room using this link:'**
  String get joinMyPredictionRoomUsingThisLink;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
