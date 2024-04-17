import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passion_picks/views/auth_pages/auth_page_switcher.dart';
import 'package:passion_picks/views/auth_pages/login_page.dart';
import 'package:passion_picks/views/auth_pages/register_page.dart';
import 'package:passion_picks/views/nav_bar_page.dart';

import 'controllers/cart_controller.dart';
import 'controllers/wishlist_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        Get.put(WishListController());
        Get.put(CartController());
      }),
      home: const AuthPageSwitcher(),
    );
  }
}
