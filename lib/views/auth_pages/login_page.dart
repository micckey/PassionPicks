import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passion_picks/config/custom_widgets.dart';
import 'package:passion_picks/config/style.dart';
import 'package:passion_picks/views/nav_bar_page.dart';

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
                    fontColor: AppColors.menuTextColor),
                const SizedBox(
                  height: 30,
                ),
                MyTextField(
                    controller: emailController,
                    onChanged: (_) {},
                    hintText: 'email'),
                const SizedBox(
                  height: 12,
                ),
                MyPasswordField(
                    hintText: 'password',
                    isHidden: isHidden,
                    toggleVisibility: toggleVisibility),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const NavBarPage());
                  },
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
                        myText: 'Don\'t have an account?',
                        fontColor: AppColors.menuTextColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: widget.switchPagesFunction,
                      child: MyTextWidget(
                          myText: 'Sign Up',
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
