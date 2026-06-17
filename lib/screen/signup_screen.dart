import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volunteer_companion_app/core/constants/app_constant.dart';
import 'package:volunteer_companion_app/core/constants/app_design.dart';
import 'package:volunteer_companion_app/provider/app_state_provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  void createAccount() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String cPassword = cPasswordController.text.trim();
    String name = nameController.text.trim();
    String phone = phoneController.text.trim();
    if (email == "" ||
        password == "" ||
        cPassword == "" ||
        name == "" ||
        phone == "") {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
    } else if (password != cPassword) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Passwords dont match")));
    } else {
      try {
        await context.read<AppStateProvider>().signUpUser(
          name,
          email,
          phone,
          password,
        );
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
            title: Text("Create An Account", style: AppTextStyles.heading),
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
                    controller: nameController,
                    decoration: InputDecoration(
                      floatingLabelStyle: TextStyle(color: AppColors.primary),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.primary),
                      ),
                      labelText: "Name",
                    ),
                  ),

                  SizedBox(height: 10),

                  TextField(
                    
                    style: AppTextStyles.body,
                    controller: phoneController,
                    decoration: InputDecoration(
                      floatingLabelStyle: TextStyle(color: AppColors.primary),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.primary),
                      ),
                      labelText: "Phone Number",
                    ),
                  ),

                  SizedBox(height: 10),
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

                  SizedBox(height: 10),

                  TextField(
                    
                    style: AppTextStyles.body,
                    controller: cPasswordController,
                    decoration: InputDecoration(
                      floatingLabelStyle: TextStyle(color: AppColors.primary),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.primary),
                      ),
                      labelText: "Confirm Password",
                    ),
                  ),

                  SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () {
                      createAccount();
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
                    child: Text("Sign Up"),
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
