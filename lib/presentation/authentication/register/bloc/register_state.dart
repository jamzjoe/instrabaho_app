part of 'register_bloc.dart';

class RegisterState extends Equatable {
  const RegisterState({this.registerProgress});
  final double? registerProgress;

  RegisterState copyWith({double? registerProgress}) {
    return RegisterState(
        registerProgress: registerProgress ?? this.registerProgress);
  }

  @override
  List<Object?> get props => [registerProgress];
}
