import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volunteer_companion_app/core/constants/app_constant.dart';
import 'package:volunteer_companion_app/core/constants/app_design.dart';
import 'package:volunteer_companion_app/provider/app_state_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    if (email == "" || password == "") {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
    } else {
      try {
        await context.read<AppStateProvider>().logInUser(email, password);
        Navigator.pushReplacementNamed(context, "/homeScreen");
      } on FirebaseAuthException catch (e) {
        String message = mapFirebaseError(e.code);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(72.0),
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.small),
          child: AppBar(
            centerTitle: true,
            title: Text("LogIn", style: AppTextStyles.heading),
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimens.radius),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  TextField(
                    
                    style: AppTextStyles.body,
                    controller: emailController,
                    decoration: InputDecoration(
                      floatingLabelStyle: TextStyle(color: AppColors.primary),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.primary),
                      ),
                      labelText: "Email Address",
                    ),
                  ),

                  SizedBox(height: 10),

                  TextField(
                    style: AppTextStyles.body,
                    controller: passwordController,
                    decoration: InputDecoration(
                      floatingLabelStyle: TextStyle(color: AppColors.primary),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.primary),
                      ),
                      labelText: "Password",
                    ),
                  ),

                  SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () {
                      login();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(
                          AppDimens.radius,
                        ),
                        side: BorderSide(width: 2),
                      ),
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.background,
                    ),
                    child: Text("Log In"),
                  ),

                  SizedBox(height: 20),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(
                          AppDimens.radius,
                        ),
                        side: BorderSide(width: 2),
                      ),
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.background,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, "/signUpScreen");
                    },
                    child: Text("Create an Account"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
