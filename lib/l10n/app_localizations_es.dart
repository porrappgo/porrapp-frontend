// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get createNewRoomTitle => 'Crea una nueva sala';

  @override
  String get competition => 'Competición';

  @override
  String get selectACompetition => 'Selecciona una competición';

  @override
  String get roomName => 'Nombre de la sala';

  @override
  String get enterRoomName => 'Introduce el nombre de la sala';

  @override
  String get roomNameIsRequired => 'El nombre de la sala es obligatorio';

  @override
  String get minimum3Characters => 'Mínimo 3 caracteres';

  @override
  String get createRoom => 'Crear sala';

  @override
  String roomCreatedSuccessfully(Object roomName) {
    return '¡Sala \"$roomName\" creada con éxito!';
  }

  @override
  String get noRoomsAvailableYet => 'No hay salas disponibles todavía.';

  @override
  String get loginTitle => 'Bienvenido de nuevo';

  @override
  String get emailLabel => 'Correo electrónico';

  @override
  String get emailHint => 'Introduce tu correo electrónico';

  @override
  String get passwordLabel => 'Contraseña';

  @override
  String get passwordHint => 'Introduce tu contraseña';

  @override
  String get dontHaveAccountRegister => '¿No tienes una cuenta? Regístrate';

  @override
  String get loginButton => 'Iniciar sesión';

  @override
  String get nameLabel => 'Nombre';

  @override
  String get nameHint => 'Introduce tu nombre';

  @override
  String get confirmPasswordLabel => 'Confirmar contraseña';

  @override
  String get confirmPasswordHint => 'Introduce tu contraseña de nuevo';

  @override
  String get registerButton => 'Registrarse';

  @override
  String get alreadyHaveAccountLogin => '¿Ya tienes una cuenta? Inicia sesión';
}
