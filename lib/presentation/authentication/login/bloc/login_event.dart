part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginContactChanged extends LoginEvent {
  const LoginContactChanged(this.contact);

  final ContactInput contact;

  @override
  List<Object> get props => [contact];
}

class LoginPasswordChanged extends LoginEvent {
  const LoginPasswordChanged(this.password);

  final PasswordInput password;

  @override
  List<Object> get props => [password];
}

class LoginSubmitted extends LoginEvent {}

class LoginBlocReset extends LoginEvent {}
