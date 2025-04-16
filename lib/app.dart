import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instrabaho_app/constant/router/router_config.dart';
import 'package:instrabaho_app/constant/styles/colors.dart';
import 'package:instrabaho_app/presentation/app/app_bloc.dart';
import 'package:instrabaho_app/presentation/authentication/profile/bloc/profile_bloc.dart';
import 'package:instrabaho_app/presentation/authentication/register/bloc/register_bloc.dart';
import 'package:instrabaho_app/presentation/dashboard/bloc/job_post_bloc.dart';
import 'package:instrabaho_app/presentation/dashboard/bloc/work_status_bloc.dart';
import 'package:instrabaho_app/presentation/home/cubit/bottom_nav_cubit.dart';
import 'package:instrabaho_app/presentation/messages/bloc/message_bloc.dart';

class InstrabahoApp extends StatelessWidget {
  const InstrabahoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(430, 932),
      minTextAdapt: true,
      enableScaleText: () => true,
      enableScaleWH: () => true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ProfileBloc()),
          BlocProvider(
            create: (context) => BottomNavCubit(),
          ),
          BlocProvider(create: (context) => JobPostBloc()),
          BlocProvider(create: (context) => MessageBloc()),
          BlocProvider(create: (context) => AppBloc()),
          BlocProvider(create: (context) => RegisterBloc()),
          BlocProvider(create: (context) => WorkStatusBloc()),
        ],
        child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              appBarTheme: AppBarTheme(color: Colors.white),
              textTheme: GoogleFonts.nunitoSansTextTheme(
                  Theme.of(context).textTheme.copyWith(
                        displayLarge: const TextStyle(
                            fontSize: 72.0, fontWeight: FontWeight.bold),
                        bodyLarge:
                            TextStyle(fontSize: 14.0, color: Colors.grey[800]),
                      )),
              colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
                  .copyWith(secondary: C.blue600)
                  .copyWith(surface: const Color.fromARGB(255, 253, 252, 250)),
            ),
            routerConfig: AppRouterConifg.routerConfig),
      ),
    );
  }
}
