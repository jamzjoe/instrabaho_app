part of 'forgot_password_bloc.dart';

class ForgotPasswordState extends Equatable {
  ForgotPasswordState({this.emailInput});
  final EmailInput? emailInput;

  ForgotPasswordState copyWith({EmailInput? emailInput}) {
    return ForgotPasswordState(
      emailInput: emailInput ?? this.emailInput,
    );
  }

  @override
  List<Object?> get props => [emailInput];
}
