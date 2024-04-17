import 'package:flutter/material.dart';

import 'login_page.dart';
import 'register_page.dart';

class AuthPageSwitcher extends StatefulWidget {
  const AuthPageSwitcher({super.key});

  @override
  State<AuthPageSwitcher> createState() => _AuthPageSwitcherState();
}

class _AuthPageSwitcherState extends State<AuthPageSwitcher> {
  bool isLoginPage = true;

  void switchAuthPages() {
    setState(() {
      isLoginPage = !isLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoginPage) {
      return LoginPage(
        switchPagesFunction: switchAuthPages,
      );
    } else {
      return RegisterPage(
        switchPagesFunction: switchAuthPages,
      );
    }
  }
}
