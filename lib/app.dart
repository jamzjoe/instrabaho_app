import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instrabaho_app/constant/router/router_config.dart';
import 'package:instrabaho_app/constant/styles/colors.dart';
import 'package:instrabaho_app/presentation/authentication/profile/bloc/profile_bloc.dart';
import 'package:instrabaho_app/presentation/dashboard/bloc/search_bloc.dart';
import 'package:instrabaho_app/presentation/home/cubit/bottom_nav_cubit.dart';

class InstrabahoApp extends StatelessWidget {
  const InstrabahoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProfileBloc()),
        BlocProvider(
          create: (context) => BottomNavCubit(),
        ),
        BlocProvider(
          create: (context) => SearchBloc(),
        ),
      ],
      child: MaterialApp.router(
          theme: ThemeData(
            textTheme: GoogleFonts.nunitoTextTheme(
              Theme.of(context).textTheme.copyWith(
                    displayLarge: const TextStyle(
                        fontSize: 72.0, fontWeight: FontWeight.bold),
                    bodyLarge:
                        TextStyle(fontSize: 14.0, color: Colors.grey[800]),
                  ),
            ),
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
                .copyWith(secondary: secondaryColor)
                .copyWith(surface: const Color.fromARGB(255, 253, 252, 250)),
          ),
          routerConfig: AppRouterConifg.routerConfig),
    );
  }
}
