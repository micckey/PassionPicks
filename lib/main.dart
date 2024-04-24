import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passion_picks/controllers/cart_controller.dart';
import 'package:passion_picks/controllers/wishlist_controller.dart';
import 'package:passion_picks/views/auth_pages/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(CartController());
  Get.put(WishListController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'QuickSand',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AuthProvider(),
    );
  }
}
