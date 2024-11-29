import 'package:formz/formz.dart';

enum EmailInputValidationError { invalid }

class EmailInput extends FormzInput<String, EmailInputValidationError>
    with FormzInputErrorCacheMixin {
  EmailInput.pure([super.value = '']) : super.pure();

  EmailInput.dirty([super.value = '']) : super.dirty();

  static final _emailRegExp = RegExp(
    r'^[a-zA-Z\d.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z\d-]+\.[a-zA-Z]{2,}$',
  );

  @override
  EmailInputValidationError? validator(String value) {
    return _emailRegExp.hasMatch(value)
        ? null
        : EmailInputValidationError.invalid;
  }
}
