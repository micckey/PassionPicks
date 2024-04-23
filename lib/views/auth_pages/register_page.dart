import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:passion_picks/views/auth_pages/auth_page_switcher.dart';
import '../../config/custom_widgets.dart';
import '../../config/style.dart';


class RegisterPage extends StatefulWidget {
  final VoidCallback switchPagesFunction;

  const RegisterPage({required this.switchPagesFunction, Key? key})
      : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //Handle password visibility
  bool isHidden = false;

  void toggleVisibility() {
    setState(() {
      isHidden = !isHidden;
    });
  }

  Future<void> registerUser() async {
    if (usernameController.text.trim() == '' ||
        emailController.text.trim() == '' ||
        locationController.text.trim() == '' ||
        passwordController.text.trim() == '') {
      buildSnackBar(
          'Error', 'Fill in all fields first', AppColors.feedbackColor);
      return;
    }

    const String url = 'https://jay.john-muinde.com/create_user.php';
    final Map<String, dynamic> data = {
      'username': usernameController.text,
      'email': emailController.text,
      'location': locationController.text,
      'password': passwordController.text,
    };

    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        body: data,
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (responseData['code'] == 1) {
        // Registration successful
        buildSnackBar(
          'Success',
          'Account Created Successfully, You may proceed to Log in',
          AppColors.cardsColor,
        );
        // Navigate to the login page
        Get.offAll(() => const AuthPageSwitcher());
      } else {
        // Display error message
        buildSnackBar(
          'Error',
          'An Unexpected Error occurred: ${responseData['message']}',
          AppColors.feedbackColor,
        );
      }
    } catch (error) {
      // Handle network errors
      buildSnackBar(
        'Network Error',
        'Check your Internet Connection',
        AppColors.feedbackColor,
      );
      print('Error: $error');
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
                  'assets/images/icon.png',
                  width: 200,
                  height: 200,
                ),
                MyTextWidget(
                    myText: 'Sign Up',
                    fontSize: 28.0,
                    fontWeight: FontWeight.w900,
                    fontColor: AppColors.menuTextColor),
                const SizedBox(
                  height: 30,
                ),
                MyTextField(
                    controller: usernameController,
                    onChanged: (_) {},
                    hintText: 'username'),
                const SizedBox(
                  height: 12,
                ),
                MyTextField(
                    controller: emailController,
                    onChanged: (_) {},
                    hintText: 'email'),
                const SizedBox(
                  height: 12,
                ),
                MyTextField(
                    controller: locationController,
                    onChanged: (_) {},
                    hintText: 'location'),
                const SizedBox(
                  height: 12,
                ),
                MyPasswordField(
                    controller: passwordController,
                    hintText: 'password',
                    isHidden: isHidden,
                    toggleVisibility: toggleVisibility),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: registerUser,
                  child: Container(
                    height: 65,
                    width: double.maxFinite,
                    color: AppColors.buttonsColor,
                    child: Center(
                        child: MyTextWidget(
                      myText: 'REGISTER',
                      fontColor: AppColors.primaryBackgroundColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 25.0,
                    )),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyTextWidget(
                        myText: 'Already have an account?',
                        fontColor: AppColors.menuTextColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: widget.switchPagesFunction,
                      child: MyTextWidget(
                          myText: 'Sign In',
                          fontColor: AppColors.titlesTextColor,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w800),
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
      )),
    );
  }
}
