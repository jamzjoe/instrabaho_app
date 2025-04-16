part of 'app_bloc.dart';

enum AuthenticationState { authenticated, unauthenticated }

class AppState extends Equatable {
  AppState(
      {this.authenticationState = AuthenticationState.unauthenticated,
      this.user});
  final AuthenticationState? authenticationState;
  final UserModel? user;

  @override
  List<Object?> get props => [authenticationState, user];

  AppState copyWith(
      {AuthenticationState? authenticationState, UserModel? user}) {
    return AppState(
        authenticationState: authenticationState ?? this.authenticationState,
        user: user ?? this.user);
  }
}
