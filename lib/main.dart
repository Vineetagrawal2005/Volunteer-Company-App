import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:volunteer_companion_app/model/badge_model.dart';
import 'package:volunteer_companion_app/model/event_model.dart';
import 'package:volunteer_companion_app/model/user_model.dart';
import 'package:volunteer_companion_app/provider/app_state_provider.dart';
import 'package:volunteer_companion_app/screen/badges_screen.dart';
import 'package:volunteer_companion_app/screen/events_screen.dart';
import 'package:volunteer_companion_app/screen/home_screen.dart';
import 'package:volunteer_companion_app/screen/login_screen.dart';
import 'package:volunteer_companion_app/screen/signup_screen.dart';
import 'package:volunteer_companion_app/screen/splash_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox<UserModel>('UserBox');
  Hive.registerAdapter(EventModelAdapter());
  await Hive.openBox<EventModel>('EventBox');
  Hive.registerAdapter(BadgeModelAdapter());
  await Hive.openBox<BadgeModel>('BadgeBox');
  final badgeBox = Hive.box<BadgeModel>('BadgeBox');
  if (badgeBox.isEmpty) {
    await badgeBox.put(
      'badge1',
      BadgeModel(
        id: 'badge1',
        name: 'First Step',
        description: 'Register for your first event',
        threshold: 1,
      ),
    );
    await badgeBox.put(
      'badge2',
      BadgeModel(
        id: 'badge2',
        name: 'Active Volunteer',
        description: 'Register for 3 events',
        threshold: 3,
      ),
    );
    await badgeBox.put(
      'badge3',
      BadgeModel(
        id: 'badge3',
        name: 'Community Pillar',
        description: 'Register for 5 events',
        threshold: 5,
      ),
    );
  }
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppStateProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        "/": (context) => SplashScreen(),
        "/eventScreen": (context) => EventsScreen(),
        "/badgeScreen": (context) => BadgesScreen(),
        "/logInScreen": (context) => LoginScreen(),
        "/signUpScreen": (context) => SignupScreen(),
        "/homeScreen": (context) => HomeScreen(),
      },
    );
  }
}
