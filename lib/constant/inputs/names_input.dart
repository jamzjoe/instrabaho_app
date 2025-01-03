import 'package:formz/formz.dart';

enum NameValidationError { empty, invalid }

class NameInput extends FormzInput<String, NameValidationError>
    with FormzInputErrorCacheMixin {
  NameInput.pure() : super.pure('');
  NameInput.dirty([super.value = '']) : super.dirty();

  static final RegExp _nameRegExp = RegExp(r'^[a-zA-Z\s]+$');

  @override
  NameValidationError? validator(String value) {
    final trimmedValue = value.trim();
    if (trimmedValue.isEmpty) {
      return NameValidationError.empty;
    }
    if (!_nameRegExp.hasMatch(trimmedValue)) {
      return NameValidationError.invalid;
    }
    return null;
  }
}
