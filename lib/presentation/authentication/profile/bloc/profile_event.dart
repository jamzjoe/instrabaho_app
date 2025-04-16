part of 'profile_bloc.dart';

class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileOnChangedFirstName extends ProfileEvent {
  const ProfileOnChangedFirstName(this.firstName);

  final String firstName;

  @override
  List<Object> get props => [firstName];
}

class ProfileOnChangedLastName extends ProfileEvent {
  const ProfileOnChangedLastName(this.lastName);

  final String lastName;

  @override
  List<Object> get props => [lastName];
}

class ProfileOnChangedEmail extends ProfileEvent {
  const ProfileOnChangedEmail(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

class ProfileOnCompleteSubmit extends ProfileEvent {
  const ProfileOnCompleteSubmit();
}

class ProfileOnChangePhoneNumber extends ProfileEvent {
  const ProfileOnChangePhoneNumber({
    required this.phoneNumber,
    this.isPhoneNumberValid,
  });

  final String phoneNumber;
  final bool? isPhoneNumberValid;

  @override
  List<Object> get props => [phoneNumber, isPhoneNumberValid ?? false];
}

class ProfileOnOTPValidation extends ProfileEvent {
  const ProfileOnOTPValidation({required this.otp, this.isOtpValid});

  final String otp;
  final bool? isOtpValid;

  @override
  List<Object> get props => [otp, isOtpValid ?? false];
}

class ProfileBlocReset extends ProfileEvent {
  const ProfileBlocReset();
}

class ProfileOnChangedPassword extends ProfileEvent {
  const ProfileOnChangedPassword(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}
