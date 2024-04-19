import 'package:flutter/material.dart';
import 'package:passion_picks/views/auth_pages/auth_page_switcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:passion_picks/views/nav_bar_page.dart';

class AuthProvider extends StatefulWidget {
  const AuthProvider({Key? key}) : super(key: key);

  @override
  _AuthProviderState createState() => _AuthProviderState();
}

class _AuthProviderState extends State<AuthProvider> {
  bool isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    checkAuthenticationStatus();
  }

  Future<void> checkAuthenticationStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    setState(() {
      isAuthenticated = token != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isAuthenticated ? const NavBarPage() : const AuthPageSwitcher();
  }
}
