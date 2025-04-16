part of 'app_bloc.dart';

sealed class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppChangeUser extends AppEvent {
  final UserModel user;

  AppChangeUser(this.user);

  @override
  List<Object> get props => [user];
}
