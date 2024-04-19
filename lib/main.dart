import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passion_picks/views/auth_pages/auth_page_switcher.dart';
import 'package:passion_picks/views/auth_pages/auth_provider.dart';
import 'package:passion_picks/views/auth_pages/login_page.dart';
import 'package:passion_picks/views/auth_pages/register_page.dart';
import 'package:passion_picks/views/nav_bar_page.dart';
import 'package:passion_picks/views/product_view_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controllers/cart_controller.dart';
import 'controllers/wishlist_controller.dart';

void main() async {
  // Ensure Flutter binding is fully initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Fetch userId asynchronously
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? userId = prefs.getString('userId');

  runApp(MyApp(userId: userId));
}

class MyApp extends StatelessWidget {
  final String? userId;

  const MyApp({super.key, this.userId});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'QuickSand',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialBinding: BindingsBuilder(() {
        // Pass userId to controllers if available
        if (userId != null) {
          Get.put(WishListController(userId: userId));
          Get.put(CartController(userId: userId));
        } else {
          // Handle case where userId is null
        }
      }),
      home: const AuthProvider(),
    );
  }
}
