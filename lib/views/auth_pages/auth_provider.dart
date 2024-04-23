import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passion_picks/controllers/cart_controller.dart';
import 'package:passion_picks/controllers/wishlist_controller.dart';
import 'package:passion_picks/views/auth_pages/auth_page_switcher.dart';
import 'package:passion_picks/views/nav_bar_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends StatefulWidget {
  const AuthProvider({super.key});

  @override
  _AuthProviderState createState() => _AuthProviderState();
}

class _AuthProviderState extends State<AuthProvider> {
  bool isAuthenticated = false;
  String? userId;
  String? userEmail;
  String? username;
  String? location;

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
      userId = prefs.getString('userId');
      userEmail = prefs.getString('userEmail');
      username = prefs.getString('username');
      location = prefs.getString('location');
      // print('AUTH STATUS::::::: $isAuthenticated');
    });
    if (isAuthenticated && userId != null) {
      // Initialize controllers with userId
      Get.put(WishListController(userId: userId!));
      Get.put(CartController(userId: userId!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return isAuthenticated
        ? NavBarPage(
            userId: userId,
            username: username,
            userEmail: userEmail,
            location: location,
          )
        : const AuthPageSwitcher();
  }
}
