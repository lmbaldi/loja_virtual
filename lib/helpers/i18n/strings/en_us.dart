import 'translations.dart';

class EnUs implements Translations {
  //labels
  String get start => 'Start';
  String get products => 'Products';
  String get order => 'My orders';
  String get store => 'Store';
  String get enter => 'Enter';
  String get password => 'Password';
  String get email => 'Email';
  String get forgetPassword => 'I forgot my password';
  String get invalidPassword => 'Invalid password';
  String get invalidEmail => 'Invalid email';
  String get typeLoginEmail => 'Type the login(email)';
  String get typePassword => 'Type the password';
  String get errorWeakPassword => 'Your password is too weak.';
  String get errorInvalidEmail => 'Your email is invalid';
  String get errorEmailAlreadyInUse => 'E-mail is already being used in another account.';
  String get errorInvalidCredential => 'Your email is invalid.';
  String get errorWrongPassword => 'Your password is incorrect.';
  String get errorUserNotFound => 'There is no user with this email.';
  String get errorUserDisable => 'This user has been disabled.';
  String get errorTooManyRequests => 'Too many requests. Try again later.';
  String get errorOperationNotAllowed => 'Operation not allowed.';
  String get errorUndefined => 'An undefined error has occurred.';
  String get errorLogin => 'Login failed. ';

}