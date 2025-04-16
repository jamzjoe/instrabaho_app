part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterOnChangeProgress extends RegisterEvent {
  final double progress;

  RegisterOnChangeProgress(this.progress);

  @override
  List<Object> get props => [progress];
}
