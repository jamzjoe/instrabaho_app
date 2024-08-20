part of 'onboarding_bloc.dart';

class OnboardingState extends Equatable {
  const OnboardingState({required this.isSplashScreen});
  final bool isSplashScreen;

  @override
  List<Object> get props => [isSplashScreen];
}
