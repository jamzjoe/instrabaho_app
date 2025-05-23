import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(const OnboardingState(isSplashScreen: true)) {
    on<OnboardingSplashScreenEvent>((event, emit) async {
      emit(const OnboardingState(isSplashScreen: true));
      await Future.delayed(const Duration(seconds: 3), () {
        emit(const OnboardingState(isSplashScreen: false));
      });
    });

    on<OnboardingBlocReset>((event, emit) {
      emit(const OnboardingState(isSplashScreen: true));
    });
    add(const OnboardingSplashScreenEvent());
  }
}
