import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:instrabaho_app/app.dart';
import 'package:splash_master/core/splash_master.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load .env file from assets
  await dotenv.load();

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
