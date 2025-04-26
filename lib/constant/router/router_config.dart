// create go router config

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:instrabaho_app/constant/router/router_names.dart';
import 'package:instrabaho_app/domain/data/worker_model.dart';
import 'package:instrabaho_app/presentation/activity/activity_details_screen.dart';
import 'package:instrabaho_app/presentation/activity/activity_screen.dart';
import 'package:instrabaho_app/presentation/authentication/email_verificaton/email_verfication.dart';
import 'package:instrabaho_app/presentation/authentication/login/login_screen.dart';
import 'package:instrabaho_app/presentation/authentication/phone_verification/phone_number_otp.dart';
import 'package:instrabaho_app/presentation/authentication/phone_verification/phone_number_verification.dart';
import 'package:instrabaho_app/presentation/authentication/profile/complete_profile_form.dart';
import 'package:instrabaho_app/presentation/dashboard/dashboard_screen.dart';
import 'package:instrabaho_app/presentation/dashboard/pages/job_post_recommendation_screen.dart';
import 'package:instrabaho_app/presentation/dashboard/pages/job_post_review_worker_screen.dart';
import 'package:instrabaho_app/presentation/dashboard/pages/job_post_screen.dart';
import 'package:instrabaho_app/presentation/dashboard/pages/job_status_screen.dart';
import 'package:instrabaho_app/presentation/dashboard/pages/qr_scanner_screen.dart';
import 'package:instrabaho_app/presentation/dashboard/pages/worker_location_screen.dart';
import 'package:instrabaho_app/presentation/home/main_screen_wrapper.dart';
import 'package:instrabaho_app/presentation/jobs/job_confirmed.dart';
import 'package:instrabaho_app/presentation/jobs/job_details.dart';
import 'package:instrabaho_app/presentation/jobs/job_map_finder.dart';
import 'package:instrabaho_app/presentation/jobs/job_search.dart';
import 'package:instrabaho_app/presentation/messages/message_conversation.dart';
import 'package:instrabaho_app/presentation/messages/messages_screen.dart';
import 'package:instrabaho_app/presentation/onboarding/bloc/onboarding_bloc.dart';
import 'package:instrabaho_app/presentation/onboarding_screen.dart';
import 'package:instrabaho_app/presentation/practice/practice_screen.dart';
import 'package:instrabaho_app/presentation/profile/profile_screen.dart';

import '../../presentation/dashboard/pages/job_post_confirmation_screen.dart';
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
            path: 'email_verification',
            name: RouterNames.emailVerification,
            builder: (context, state) => const EmailVerification(),
          ),
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
                    builder: (context, state) => CompleteProfileForm(),
                  ),
                ],
                builder: (context, state) => const PhoneNumberOtp(),
              ),
            ],
            builder: (context, state) => const PhoneNumberVerification(),
          ),
          GoRoute(
            path: 'login',
            name: RouterNames.login,
            routes: [
              GoRoute(
                path: 'practice_screen',
                name: RouterNames.practiceScreen,
                builder: (context, state) => const PracticeScreen(),
              ),
              // GoRoute(
              //   path: 'face_detection_test',
              //   name: RouterNames.faceDetectionTest,
              //   builder: (context, state) => const FaceDetectionScreen(),
              // ),
              // GoRoute(
              //   path: 'face_detection_match_test',
              //   name: RouterNames.faceDetectionMatchTest,
              //   builder: (context, state) => const MatchFaceDetection(),
              // ),
            ],
            builder: (context, state) => const LoginScreen(),
          ),
        ],
      ),
      StatefulShellRoute.indexedStack(
        parentNavigatorKey: _rootNavigatorKey,
        branches: [
          StatefulShellBranch(
            navigatorKey: _homeBranchNavigatorKey,
            routes: [
              GoRoute(
                path: '/home',
                name: RouterNames.home,
                builder: (context, state) => const Dashboard(),
                routes: [
                  GoRoute(
                    parentNavigatorKey: _rootNavigatorKey,
                    path: 'job-post',
                    name: RouterNames.jobPost,
                    builder: (context, state) => const JobPostScreen(),
                  ),
                  GoRoute(
                    parentNavigatorKey: _rootNavigatorKey,
                    path: 'job-status',
                    name: RouterNames.jobStatus,
                    builder: (context, state) => const JobStatusScreen(),
                    routes: [
                      GoRoute(
                        parentNavigatorKey: _rootNavigatorKey,
                        path: 'worker_location',
                        name: RouterNames.workerLocation,
                        builder: (context, state) =>
                            const WorkerLocationScreen(),
                      ),
                      GoRoute(
                        parentNavigatorKey: _rootNavigatorKey,
                        path: 'review-worker',
                        name: RouterNames.reviewRoker,
                        builder: (context, state) =>
                            const JobPostReviewWorkerScreen(),
                      ),
                      GoRoute(
                        parentNavigatorKey: _rootNavigatorKey,
                        path: 'qr-scanner',
                        name: RouterNames.qrScanner,
                        builder: (context, state) => const QRScannerScreen(),
                      ),
                    ],
                  ),
                  GoRoute(
                    parentNavigatorKey: _rootNavigatorKey,
                    path: 'job-post-confirmation-screen',
                    name: RouterNames.jobPostConfirmationScreen,
                    builder: (context, state) =>
                        const JobPostConfirmationScreen(),
                  ),
                  GoRoute(
                    parentNavigatorKey: _rootNavigatorKey,
                    path: 'job-post-recommendation-screen',
                    name: RouterNames.jobPostRecommendationScreen,
                    builder: (context, state) =>
                        const JobPostRecommendationScreen(),
                  ),
                  GoRoute(
                    path: 'job-details',
                    name: RouterNames.jobDetails,
                    builder: (context, state) => const JobDetailScreen(),
                  ),
                  GoRoute(
                    path: 'job-search',
                    name: RouterNames.jobSearch,
                    builder: (context, state) => const JobSearchScreen(),
                  ),
                  GoRoute(
                    path: 'job-map-finder',
                    name: RouterNames.jobMapFinder,
                    builder: (context, state) => const JobMapFinderScreen(),
                  ),
                  GoRoute(
                    parentNavigatorKey: _rootNavigatorKey,
                    path: 'job-confirmed-screen',
                    name: RouterNames.jobConfirmedScreen,
                    builder: (context, state) => const JobConfirmedScreen(),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _interviewsNavigatorKey,
            routes: [
              GoRoute(
                path: '/activity',
                name: RouterNames.activity,
                builder: (context, state) => const ActivityScreen(),
                routes: [
                  GoRoute(
                    parentNavigatorKey: _rootNavigatorKey,
                    path: 'activity-details',
                    name: RouterNames.activityDetails,
                    builder: (context, state) => const ActivityDetailsScreen(),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _messagesNavigatorKey,
            routes: [
              GoRoute(
                path: '/messages',
                name: RouterNames.messages,
                builder: (context, state) => MessagesScreen(),
                routes: [
                  GoRoute(
                    parentNavigatorKey: _rootNavigatorKey,
                    path: 'message_conversation',
                    name: RouterNames.messageConversation,
                    builder: (context, state) =>
                        MessageConversation(worker: state.extra as WorkerModel),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _profileNavigatorKey,
            routes: [
              GoRoute(
                path: '/profile',
                name: RouterNames.profile,
                builder: (context, state) => const Profile(),
              ),
            ],
          ),
        ],
        builder: (context, state, navigationShell) =>
            MainScreenWrapper(navigationShell: navigationShell),
      ),
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
