part of 'onboarding_bloc.dart';

sealed class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object> get props => [];
}

class OnboardingSplashScreenEvent extends OnboardingEvent {
  const OnboardingSplashScreenEvent();
}

class OnboardingBlocReset extends OnboardingEvent {
  const OnboardingBlocReset();
}
