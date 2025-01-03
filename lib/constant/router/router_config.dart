// create go router config

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:instrabaho_app/constant/router/router_names.dart';
import 'package:instrabaho_app/domain/data/worker_model.dart';
import 'package:instrabaho_app/presentation/activity/activity_details_screen.dart';
import 'package:instrabaho_app/presentation/activity/activity_screen.dart';
import 'package:instrabaho_app/presentation/authentication/login/bloc/login_bloc.dart';
import 'package:instrabaho_app/presentation/authentication/login/login_screen.dart';
import 'package:instrabaho_app/presentation/authentication/phone_verification/phone_number_otp.dart';
import 'package:instrabaho_app/presentation/authentication/phone_verification/phone_number_verification.dart';
import 'package:instrabaho_app/presentation/authentication/profile/complete_profile_form.dart';
import 'package:instrabaho_app/presentation/authentication/register/register_screen.dart';
import 'package:instrabaho_app/presentation/dashboard/dashboard_screen.dart';
import 'package:instrabaho_app/presentation/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:instrabaho_app/presentation/forgot_password/forgot_password_screen.dart';
import 'package:instrabaho_app/presentation/forgot_password/forgot_password_verification.dart';
import 'package:instrabaho_app/presentation/home/main_screen_wrapper.dart';
import 'package:instrabaho_app/presentation/jobs/job_details.dart';
import 'package:instrabaho_app/presentation/jobs/job_map_finder.dart';
import 'package:instrabaho_app/presentation/jobs/job_search.dart';
import 'package:instrabaho_app/presentation/messages/message_conversation.dart';
import 'package:instrabaho_app/presentation/messages/messages_screen.dart';
import 'package:instrabaho_app/presentation/onboarding/bloc/onboarding_bloc.dart';
import 'package:instrabaho_app/presentation/onboarding/onboarding_user_selection_screen.dart';
import 'package:instrabaho_app/presentation/onboarding_screen.dart';
import 'package:instrabaho_app/presentation/practice/practice_screen.dart';
import 'package:instrabaho_app/presentation/profile/profile_screen.dart';

import '../../presentation/onboarding/splash_screen.dart';

class AppRouterConifg {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _homeBranchNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'home_key');
  static final _interviewsNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'interviews_key');
  static final _messagesNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'messages_key');
  static final _profileNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'profile_key');
  static final GoRouter routerConfig = GoRouter(
    initialLocation: "/",
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    observers: [
      AppNavigatorObserver(),
    ],
    routes: [
      GoRoute(
        path: '/',
        name: RouterNames.splash,
        builder: (context, state) => BlocProvider(
          create: (context) => OnboardingBloc(),
          child: const SplashScreen(),
        ),
      ),
      GoRoute(
          parentNavigatorKey: _rootNavigatorKey,
          path: '/onboarding',
          name: RouterNames.onboarding,
          builder: (context, state) => const OnboardingScreen(),
          routes: [
            GoRoute(
                path: 'user-selection',
                name: RouterNames.onboardingUserSelection,
                builder: (context, state) =>
                    const OnboardingUserSelectionScreen(),
                routes: [
                  GoRoute(
                    path: 'login',
                    name: RouterNames.login,
                    routes: [
                      GoRoute(
                        path: 'practice_screen',
                        name: RouterNames.practiceScreen,
                        builder: (context, state) => const PracticeScreen(),
                      ),
                      GoRoute(
                        path: 'forgot_password',
                        name: RouterNames.forgot_password,
                        builder: (context, state) => BlocProvider(
                          create: (context) => ForgotPasswordBloc(),
                          child: const ForgotPasswordScreen(),
                        ),
                      ),
                      GoRoute(
                        path: 'forgot_password_verification',
                        name: RouterNames.forgot_password_verification,
                        builder: (context, state) =>
                            const ForgotPasswordVerificationScreen(),
                      ),
                    ],
                    builder: (context, state) => BlocProvider(
                      create: (context) => LoginBloc(),
                      child: const LoginScreen(),
                    ),
                  ),
                  GoRoute(
                    path: 'register',
                    name: RouterNames.register,
                    routes: [
                      GoRoute(
                        path: 'phone_number_verification',
                        name: RouterNames.phoneNumberVerification,
                        routes: [
                          GoRoute(
                            path: 'otp',
                            name: RouterNames.otp,
                            routes: [
                              GoRoute(
                                path: 'complete_profile',
                                name: RouterNames.completeProfile,
                                builder: (context, state) =>
                                    CompleteProfileForm(),
                              ),
                            ],
                            builder: (context, state) => const PhoneNumberOtp(),
                          ),
                        ],
                        builder: (context, state) =>
                            const PhoneNumberVerification(),
                      ),
                    ],
                    builder: (context, state) => const RegisterScreen(),
                  ),
                ]),
          ]),
      StatefulShellRoute.indexedStack(
        parentNavigatorKey: _rootNavigatorKey,
        branches: [
          StatefulShellBranch(navigatorKey: _homeBranchNavigatorKey, routes: [
            GoRoute(
                path: '/home',
                name: RouterNames.home,
                builder: (context, state) => const Dashboard(),
                routes: [
                  GoRoute(
                    path: 'job-details',
                    name: RouterNames.jobDetails,
                    builder: (context, state) => const JobDetailScreen(),
                  ),
                  GoRoute(
                      parentNavigatorKey: _rootNavigatorKey,
                      path: 'job-search',
                      name: RouterNames.jobSearch,
                      builder: (context, state) => const JobSearchScreen(),
                      routes: []),
                  GoRoute(
                    parentNavigatorKey: _rootNavigatorKey,
                    path: 'job-map-finder',
                    name: RouterNames.jobMapFinder,
                    builder: (context, state) => const JobMapFinderScreen(),
                  ),
                ]),
          ]),
          StatefulShellBranch(navigatorKey: _interviewsNavigatorKey, routes: [
            GoRoute(
                path: '/activity',
                name: RouterNames.activity,
                builder: (context, state) => const ActivityScreen(),
                routes: [
                  GoRoute(
                    path: 'activity-details',
                    name: RouterNames.activityDetails,
                    builder: (context, state) => const ActivityDetailsScreen(),
                  ),
                ]),
          ]),
          StatefulShellBranch(
              observers: [AppNavigatorObserver()],
              navigatorKey: _messagesNavigatorKey,
              routes: [
                GoRoute(
                  path: '/messages',
                  name: RouterNames.messages,
                  routes: [
                    GoRoute(
                        parentNavigatorKey: _rootNavigatorKey,
                        path: 'message_conversation',
                        name: RouterNames.messageConversation,
                        builder: (context, state) => MessagesConversationScreen())
                  ],
                  builder: (context, state) => Messages(),
                ),
              ]),
          StatefulShellBranch(navigatorKey: _profileNavigatorKey, routes: [
            GoRoute(
                path: '/profile',
                name: RouterNames.profile,
                builder: (context, state) => const Profile()),
          ])
        ],
        builder: (context, state, navigationShell) =>
            MainScreenWrapper(navigationShell: navigationShell),
      )
    ],
  );
}

List<String> history = [];

class AppNavigatorObserver extends NavigatorObserver {
  String? get prevRoute => history.isNotEmpty ? history.last : 'initial_route';

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    final currentRoute = route.settings.name ?? 'initial_route';

    if (currentRoute != prevRoute) {
      history.add(currentRoute);
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    history.remove(route.settings.name ?? '');

    if (prevRoute == null) {
      return;
    }
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    history.remove(route.settings.name ?? '');
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (oldRoute != null) {
      history.remove(oldRoute.settings.name!);
    }
    if (newRoute != null) {
      history.add(newRoute.settings.name!);
    }
  }
}
