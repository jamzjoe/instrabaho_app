part of 'profile_bloc.dart';

enum ProfileCreationStatus { initial, loading, success, failure }

class ProfileState extends Equatable {
  const ProfileState(
      {this.phoneNumber = '',
      this.isPhoneNumberValid = false,
      this.otp = '',
      this.isOtpValid = false,
      this.firstName,
      this.lastName,
      this.email,
      this.password,
      this.profileCreationStatus = ProfileCreationStatus.initial});

  final String phoneNumber;
  final bool isPhoneNumberValid;

  final String otp;
  final bool isOtpValid;

  final NameInput? firstName;
  final NameInput? lastName;
  final EmailInput? email;

  final PasswordInput? password;

  final ProfileCreationStatus profileCreationStatus;

  ProfileState copyWith(
      {String? phoneNumber,
      bool? isPhoneNumberValid,
      String? otp,
      bool? isOtpValid,
      NameInput? firstName,
      NameInput? lastName,
      EmailInput? email,
      PasswordInput? password,
      ProfileCreationStatus? profileCreationStatus}) {
    return ProfileState(
        phoneNumber: phoneNumber ?? this.phoneNumber,
        isPhoneNumberValid: isPhoneNumberValid ?? this.isPhoneNumberValid,
        otp: otp ?? this.otp,
        isOtpValid: isOtpValid ?? this.isOtpValid,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        password: password ?? this.password,
        profileCreationStatus:
            profileCreationStatus ?? this.profileCreationStatus);
  }

  @override
  List<Object?> get props => [
        phoneNumber,
        isPhoneNumberValid,
        otp,
        isOtpValid,
        firstName,
        lastName,
        email,
        password,
        profileCreationStatus
      ];
}
