part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginEmailChanged extends LoginEvent {
  const LoginEmailChanged(this.email);

  final EmailInput email;

  @override
  List<Object> get props => [email];
}

class LoginPasswordChanged extends LoginEvent {
  const LoginPasswordChanged(this.password);

  final PasswordInput password;

  @override
  List<Object> get props => [password];
}

class LoginBlocReset extends LoginEvent {
  const LoginBlocReset();
}

class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();
}
