import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:instrabaho_app/constant/router/router_names.dart';
import 'package:instrabaho_app/gen/assets.gen.dart';
import 'package:instrabaho_app/presentation/onboarding/bloc/onboarding_bloc.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnboardingBloc, OnboardingState>(
      listenWhen: (previous, current) =>
          previous.isSplashScreen != current.isSplashScreen,
      listener: (context, state) {
        if (!state.isSplashScreen) {
          context.pushReplacementNamed(RouterNames.onboarding);
        }
      },
      child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 253, 252, 250),
          body: Center(
              child: LottieBuilder.asset(Assets.json.instrabahoSplashCopy,
                  repeat: false, frameRate: FrameRate.max))),
    );
  }
}
