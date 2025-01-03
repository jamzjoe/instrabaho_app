import 'package:formz/formz.dart';

enum PasswordValidationError { empty, tooShort, noUpperCase, noDigit }

class PasswordInput extends FormzInput<String, PasswordValidationError>
    with FormzInputErrorCacheMixin {
  PasswordInput.pure() : super.pure('');
  PasswordInput.dirty([super.value = '']) : super.dirty();

  static final RegExp _upperCaseRegExp = RegExp(r'[A-Z]');
  static final RegExp _digitRegExp = RegExp(r'\d');

  @override
  PasswordValidationError? validator(String value) {
    final trimmedValue = value.trim();
    if (trimmedValue.isEmpty) {
      return PasswordValidationError.empty;
    }
    if (trimmedValue.length < 8) {
      return PasswordValidationError.tooShort;
    }
    if (!_upperCaseRegExp.hasMatch(trimmedValue)) {
      return PasswordValidationError.noUpperCase;
    }
    if (!_digitRegExp.hasMatch(trimmedValue)) {
      return PasswordValidationError.noDigit;
    }
    return null;
  }
}
