import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instrabaho_app/domain/data/user_model.dart';
import 'package:instrabaho_app/domain/services/local_storage_service.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppState()) {
    on<AppChangeUser>((event, emit) async {
      log("AppChangeUser");
      // Save user to SharedPreferences
      await LocalStorageService.saveUser(event.user);
      emit(state.copyWith(
          user: event.user,
          authenticationState: AuthenticationState.authenticated));
    });

    on<AppCheckAuth>((event, emit) async {
      log("AppCheckAuth");
      // Check if user exists in SharedPreferences
      final user = await LocalStorageService.getUser();
      if (user != null) {
        emit(state.copyWith(
            user: user,
            authenticationState: AuthenticationState.authenticated));
      } else {
        emit(state.copyWith(
            authenticationState: AuthenticationState.unauthenticated));
      }
    });

    // Trigger initial auth check
    add(const AppCheckAuth());
  }
}
