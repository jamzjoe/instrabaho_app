import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instrabaho_app/constant/inputs/email_input.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordState()) {
    on<ForgotPasswordEmailChanged>((event, emit) {
      emit(state.copyWith(emailInput: EmailInput.dirty(event.email)));
    });

    on<ForgotPasswordReset>((event, emit) {
      emit(ForgotPasswordState());
    });
  }
}
