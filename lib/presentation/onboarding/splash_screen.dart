import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:instrabaho_app/constant/router/router_names.dart';
import 'package:instrabaho_app/gen/assets.gen.dart';
import 'package:instrabaho_app/presentation/onboarding/bloc/onboarding_bloc.dart';

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
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(Assets.images.instrabahoLogo.path),
              const Gap(10),
              const Text("Job well done!")
              //make progress bar linear 5 seconds
            ],
          ))),
    );
  }
}
