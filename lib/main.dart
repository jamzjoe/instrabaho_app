import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instrabaho_app/app.dart';
import 'package:splash_master/core/splash_master.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SplashMaster.initialize();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // _requestNotifAccess();
  Bloc.observer = TalkerBlocObserver();

  // _getFCMToken();
  runApp(const InstrabahoApp());
}

// void _requestNotifAccess() {
//   FirebaseMessaging.instance.requestPermission();
// }

// void _getFCMToken() {
//   // Get the token each time the application loads
//   FirebaseMessaging.instance.getToken().then((String? token) {
//     assert(token != null);
//     print('FCM Token: $token');
//   });
// }
