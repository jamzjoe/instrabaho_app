import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instrabaho_app/constant/inputs/email_input.dart';
import 'package:instrabaho_app/constant/inputs/password_input.dart';
import 'package:instrabaho_app/domain/data/user_model.dart';
import 'package:instrabaho_app/presentation/app/app_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AppBloc authBloc;
  LoginBloc({required this.authBloc}) : super(LoginState()) {
    on<LoginEmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email));
    });

    on<LoginPasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });

    on<LoginSubmitted>((event, emit) {
      authBloc.add(AppChangeUser(UserModel(
          id: '1', name: '', email: state.email?.value ?? '', photoUrl: '')));
    });

    on<LoginBlocReset>((event, emit) {
      emit(LoginState());
    });
  }
}
