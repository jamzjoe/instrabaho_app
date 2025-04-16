import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterState(registerProgress: .20)) {
    on<RegisterOnChangeProgress>((event, emit) {
      emit(state.copyWith(registerProgress: event.progress));
    });
  }
}
