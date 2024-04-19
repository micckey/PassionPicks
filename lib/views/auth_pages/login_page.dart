import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Add this import
import 'package:get/get.dart';
import 'package:passion_picks/config/custom_widgets.dart';
import 'package:passion_picks/config/style.dart';
import 'package:passion_picks/views/auth_pages/auth_provider.dart';
import 'package:passion_picks/views/nav_bar_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user_model.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback switchPagesFunction;

  const LoginPage({required this.switchPagesFunction, super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //Handle password visibility
  bool isHidden = false;

  void toggleVisibility() {
    setState(() {
      isHidden = !isHidden;
    });
  }

  Future<void> loginUser() async {
    if (emailController.text.trim() == '' ||
        passwordController.text.trim() == '') {
      buildSnackBar(
          'Error', 'Fill in all fields first', AppColors.feedbackColor);
    }

    const String url = 'https://jay.john-muinde.com/login.php';
    final Map<String, dynamic> data = {
      'email': emailController.text,
      'password': passwordController.text,
    };

    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        body: data,
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (responseData['status'] == 'success') {
          // Parse user data from response
          final User user = User.fromJson(responseData['user']);

          // Save user data to shared preferences
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('userId', user.id);
          prefs.setString('userEmail', user.email);
          prefs.setString('username', user.username);
          prefs.setString('location', user.location);

          // Save token to shared preferences
          prefs.setString('token', 'auth_token');

          // Login successful, navigate to the next page
          Get.to(() => const AuthProvider());
        } else {
          // Display error message
          if (responseData['message'] == 'Invalid email or password') {
            buildSnackBar(
                'Error', 'Invalid email or password', AppColors.feedbackColor);
          }
        }
      } else {
        // Handle non-200 status codes
        buildSnackBar('Error', 'An Unexpected Error occurred ${response.body}',
            AppColors.feedbackColor);
      }
    } catch (error) {
      if (error.toString().contains(' Network is unreachable')) {
        buildSnackBar('Network Error', 'Check your Internet Connection',
            AppColors.feedbackColor);
      } else {
        buildSnackBar(
            'Error', 'An Unexpected Error occurred', AppColors.feedbackColor);
        // print(error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: 200,
                    height: 200,
                  ),
                  MyTextWidget(
                    myText: 'Sign In',
                    fontSize: 28.0,
                    fontWeight: FontWeight.w900,
                    fontColor: AppColors.menuTextColor,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  MyTextField(
                    controller: emailController,
                    onChanged: (_) {},
                    hintText: 'email',
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  MyPasswordField(
                    controller: passwordController,
                    onChanged: (_) {},
                    hintText: 'password',
                    isHidden: isHidden,
                    toggleVisibility: toggleVisibility,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: loginUser, // Call loginUser function on tap
                    child: Container(
                      height: 65,
                      width: double.maxFinite,
                      color: AppColors.buttonsColor,
                      child: Center(
                        child: MyTextWidget(
                          myText: 'LOGIN',
                          fontColor: AppColors.primaryBackgroundColor,
                          fontWeight: FontWeight.w900,
                          fontSize: 25.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyTextWidget(
                        myText: 'Don\'t have an account?',
                        fontColor: AppColors.menuTextColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: widget.switchPagesFunction,
                        child: MyTextWidget(
                          myText: 'Sign Up',
                          fontColor: AppColors.titlesTextColor,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 200,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
