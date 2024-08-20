// create go router config

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:instrabaho_app/constant/router/router_names.dart';
import 'package:instrabaho_app/presentation/authentication/login/login_screen.dart';
import 'package:instrabaho_app/presentation/authentication/register/register_screen.dart';
import 'package:instrabaho_app/presentation/dashboard/dashboard_screen.dart';
import 'package:instrabaho_app/presentation/home/main_screen_wrapper.dart';
import 'package:instrabaho_app/presentation/interviews/interviews_screen.dart';
import 'package:instrabaho_app/presentation/messages/messages_screen.dart';
import 'package:instrabaho_app/presentation/onboarding/onboarding_user_selection_screen.dart';
import 'package:instrabaho_app/presentation/onboarding_screen.dart';
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
        builder: (context, state) => const SplashScreen(),
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
                    builder: (context, state) =>
                        LoginScreen(userType: state.extra as String),
                  ),
                  GoRoute(
                    path: 'register',
                    name: RouterNames.register,
                    builder: (context, state) =>
                        RegisterScreen(userType: state.extra as String),
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
            ),
          ]),
          StatefulShellBranch(navigatorKey: _interviewsNavigatorKey, routes: [
            GoRoute(
              path: '/interviews',
              name: RouterNames.interviews,
              builder: (context, state) => const Interviews(),
            ),
          ]),
          StatefulShellBranch(navigatorKey: _messagesNavigatorKey, routes: [
            GoRoute(
              path: '/messages',
              name: RouterNames.messages,
              builder: (context, state) => Messages(),
            ),
          ]),
          StatefulShellBranch(navigatorKey: _profileNavigatorKey, routes: [
            GoRoute(
              path: '/profile',
              name: RouterNames.profile,
              builder: (context, state) => const Profile(),
            ),
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
