import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:instrabaho_app/constant/inputs/contact_input.dart';
import 'package:instrabaho_app/constant/inputs/password_input.dart';
import 'package:instrabaho_app/domain/data/user_model.dart';
import 'package:instrabaho_app/domain/models/auth/login_request.dart';
import 'package:instrabaho_app/presentation/app/app_bloc.dart';
import 'package:instrabaho_app/presentation/authentication/repositories/authentication_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AppBloc authBloc;
  final AuthenticationRepository authRepository;

  LoginBloc({
    required this.authBloc,
    required this.authRepository,
  }) : super(LoginState()) {
    on<LoginContactChanged>((event, emit) {
      emit(state.copyWith(contact: event.contact));
    });

    on<LoginPasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });

    on<LoginSubmitted>((event, emit) async {
      if (state.contact?.isValid == true && state.password?.isValid == true) {
        emit(state.copyWith(status: LoginStatus.loading));
        try {
          final loginRequest = LoginRequest(
            contactNumber: state.contact!.value,
            countryCode: "63",
            password: state.password!.value,
          );
          log("Login Request ${loginRequest.toJson()}");
          final response = await authRepository.loginClient(loginRequest);
          log("Login Response ${response.toJson()}");

          if (response.user != null) {
            final user = response.user!;
            authBloc.add(AppChangeUser(UserModel(
              id: user.id.toString(),
              name: '${user.firstName ?? ''} ${user.lastName ?? ''}'.trim(),
              email: user.email ?? '',
              photoUrl: user.profilePhoto ?? '',
            )));

            emit(state.copyWith(status: LoginStatus.success));
          } else {
            final errorMessage = response.message ?? "Invalid credentials";
            log("Login Error: $errorMessage");
            Fluttertoast.showToast(
                msg: errorMessage,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
            emit(state.copyWith(
              status: LoginStatus.failure,
              errorMessage: errorMessage,
            ));
          }
        } catch (e, stackTrace) {
          log("Login Error: $e");
          log("Stack Trace: $stackTrace");
          Fluttertoast.showToast(
              msg: "An error occurred. Please try again.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          emit(state.copyWith(
            status: LoginStatus.failure,
            errorMessage: "An error occurred. Please try again.",
          ));
        }
      }
    });

    on<LoginBlocReset>((event, emit) {
      emit(LoginState());
    });
  }
}
