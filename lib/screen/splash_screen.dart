import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volunteer_companion_app/core/constants/app_design.dart';
import 'package:volunteer_companion_app/model/user_model.dart';
import 'package:volunteer_companion_app/provider/app_state_provider.dart';
import 'package:volunteer_companion_app/service/hive_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () async {
      if (FirebaseAuth.instance.currentUser != null) {
        String uid = FirebaseAuth.instance.currentUser!.uid;

        UserModel? user = await getUserByUid(uid);

        if (user != null) {
          context.read<AppStateProvider>().setCurrentUser(user);

          await context.read<AppStateProvider>().loadEvent();

          Navigator.pushReplacementNamed(context, "/homeScreen");
        } else {
          Navigator.pushReplacementNamed(context, "/logInScreen");
        }
      } else {
        Navigator.pushReplacementNamed(context, "/logInScreen");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Text(
            "Volunteer Companion App",
            style: AppTextStyles.topHeading,
          ),
        ),
      ),
    );
  }
}
