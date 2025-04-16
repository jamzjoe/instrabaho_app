import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instrabaho_app/domain/data/user_model.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppState()) {
    on<AppChangeUser>((event, emit) {
      log("AppChangeUser");
      emit(state.copyWith(
          user: event.user,
          authenticationState: AuthenticationState.authenticated));
    });
  }
}
