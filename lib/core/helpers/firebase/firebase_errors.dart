
import 'package:loja_virtual/core/helpers/i18n/resources.dart';

String getErrorString(String code) {
  switch (code) {
    case 'ERROR_WEAK_PASSWORD':
      return R.string.errorWeakPassword;
    case 'ERROR_INVALID_EMAIL':
      return R.string.errorInvalidEmail;
    case 'ERROR_EMAIL_ALREADY_IN_USE':
      return R.string.errorEmailAlreadyInUse;
    case 'ERROR_INVALID_CREDENTIAL':
      return R.string.errorInvalidCredential;
    case 'ERROR_WRONG_PASSWORD':
      return R.string.errorWrongPassword;
    case 'ERROR_USER_NOT_FOUND':
      return R.string.errorUserNotFound;
    case 'ERROR_USER_DISABLED':
      return R.string.errorUserDisable;
    case 'ERROR_TOO_MANY_REQUESTS':
      return R.string.errorTooManyRequests;
    case 'ERROR_OPERATION_NOT_ALLOWED':
      return R.string.errorOperationNotAllowed;
    default:
      return R.string.errorUndefined;
  }
}