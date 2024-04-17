import 'package:flutter/material.dart';

import '../../config/custom_widgets.dart';
import '../../config/style.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback switchPagesFunction;

  const RegisterPage({required this.switchPagesFunction, super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //Handle password visibility
  bool isHidden = false;

  void toggleVisibility() {
    setState(() {
      isHidden = !isHidden;
    });
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
                    controller: emailController,
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
                    controller: emailController,
                    onChanged: (_) {},
                    hintText: 'location'),
                const SizedBox(
                  height: 12,
                ),
                MyPasswordField(
                    hintText: 'password',
                    isHidden: isHidden,
                    toggleVisibility: toggleVisibility),
                const SizedBox(
                  height: 12,
                ),
                MyPasswordField(
                    hintText: 'password confirmation',
                    isHidden: isHidden,
                    toggleVisibility: toggleVisibility),
                const SizedBox(
                  height: 20,
                ),
                Container(
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
