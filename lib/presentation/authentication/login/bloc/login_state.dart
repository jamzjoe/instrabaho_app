part of 'login_bloc.dart';

class LoginState extends Equatable {
  LoginState({this.email, this.password});
  final EmailInput? email;
  final PasswordInput? password;

  @override
  List<Object?> get props => [email, password];

  LoginState copyWith({EmailInput? email, PasswordInput? password}) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
