import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instrabaho_app/constant/inputs/email_input.dart';
import 'package:instrabaho_app/constant/inputs/names_input.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileState()) {
    on<ProfileOnChangedFirstName>((event, emit) {
      emit(state.copyWith(firstName: NameInput.dirty(event.firstName)));
    });

    on<ProfileOnChangedLastName>((event, emit) {
      emit(state.copyWith(lastName: NameInput.dirty(event.lastName)));
    });

    on<ProfileOnChangedEmail>((event, emit) {
      emit(state.copyWith(email: EmailInput.dirty(event.email)));
    });

    on<ProfileOnCompleteSubmit>((event, emit) {
      emit(
          state.copyWith(profileCreationStatus: ProfileCreationStatus.loading));
      emit(const ProfileState(
          profileCreationStatus: ProfileCreationStatus.success));
    });

    on<ProfileOnChangePhoneNumber>((event, emit) {
      emit(state.copyWith(
          phoneNumber: event.phoneNumber,
          isPhoneNumberValid: event.isPhoneNumberValid));
    });

    on<ProfileOnOTPValidation>((event, emit) {
      emit(state.copyWith(
        otp: event.otp,
        isOtpValid: event.isOtpValid,
      ));
    });
  }
}
