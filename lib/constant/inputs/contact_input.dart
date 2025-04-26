import 'package:formz/formz.dart';

enum ContactInputValidationError { invalid }

class ContactInput extends FormzInput<String, ContactInputValidationError> {
  const ContactInput.pure() : super.pure('');
  const ContactInput.dirty([String value = '']) : super.dirty(value);

  @override
  ContactInputValidationError? validator(String value) {
    if (value.isEmpty) return null;
    // Basic validation for contact number (can be enhanced based on requirements)
    final phoneRegex = RegExp(r'^[0-9]{10,11}$');
    return phoneRegex.hasMatch(value)
        ? null
        : ContactInputValidationError.invalid;
  }
}
