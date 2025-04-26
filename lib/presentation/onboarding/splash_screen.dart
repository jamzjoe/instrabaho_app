import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:instrabaho_app/constant/router/router_names.dart';
import 'package:instrabaho_app/gen/assets.gen.dart';
import 'package:instrabaho_app/presentation/app/app_bloc.dart';
import 'package:splash_master/splash_master.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listener: (context, state) {
        if (state.authenticationState == AuthenticationState.authenticated) {
          context.pushReplacementNamed(RouterNames.home);
        } else {
          context.pushReplacementNamed(RouterNames.onboarding);
        }
      },
      child: SplashMaster.lottie(
        customNavigation: () {
          // Navigation will be handled by the BlocListener above
        },
        source: AssetSource(Assets.json.instrabahoSplashCopy),
      ),
    );
  }
}
