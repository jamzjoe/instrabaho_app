part of 'forgot_password_bloc.dart';

sealed class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class ForgotPasswordEmailChanged extends ForgotPasswordEvent {
  const ForgotPasswordEmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

class ForgotPasswordReset extends ForgotPasswordEvent {
  const ForgotPasswordReset();

  @override
  List<Object> get props => [];
}
