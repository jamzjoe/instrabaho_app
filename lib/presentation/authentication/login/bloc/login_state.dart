part of 'login_bloc.dart';

enum LoginStatus { initial, loading, success, failure }

class LoginState extends Equatable {
  const LoginState({
    this.contact,
    this.password,
    this.status = LoginStatus.initial,
    this.errorMessage,
  });

  final ContactInput? contact;
  final PasswordInput? password;
  final LoginStatus status;
  final String? errorMessage;

  LoginState copyWith({
    ContactInput? contact,
    PasswordInput? password,
    LoginStatus? status,
    String? errorMessage,
  }) {
    return LoginState(
      contact: contact ?? this.contact,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [contact, password, status, errorMessage];
}
