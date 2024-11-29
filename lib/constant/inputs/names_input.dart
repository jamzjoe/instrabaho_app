import 'package:formz/formz.dart';

enum NameValidationError { empty, invalid }

class NameInput extends FormzInput<String, NameValidationError>
    with FormzInputErrorCacheMixin {
  NameInput.pure() : super.pure('');
  NameInput.dirty([super.value = '']) : super.dirty();

  static final RegExp _nameRegExp = RegExp(r'^[a-zA-Z]+$');

  @override
  NameValidationError? validator(String value) {
    if (!_nameRegExp.hasMatch(value)) {
      return NameValidationError.invalid;
    }
    return null;
  }
}
