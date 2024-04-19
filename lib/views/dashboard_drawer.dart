import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passion_picks/config/style.dart';
import 'package:passion_picks/views/auth_pages/auth_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/custom_widgets.dart';

class DashBoardDrawer extends StatelessWidget {
  const DashBoardDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.primaryBackgroundColor,
      child: SafeArea(
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                  radius: 100,
                  child: Image.asset(
                    'assets/images/icon.png',
                    width: 150,
                    height: 150,
                    fit: BoxFit.contain,
                  )),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  MyTextWidget(
                      myText: 'ABOUT',
                      fontSize: 18.0,
                      fontWeight: FontWeight.w800,
                      fontColor: AppColors.menuTextColor),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.menuTextColor.withOpacity(0.4)),
                    child: MyHomePageTextWidget(
                        myText:
                            'Welcome to "PassionPick" – your one-stop shop for all things passion fruit! From tantalizing jams to refreshing juices, creamy ice creams to luscious cakes, and even premium oil and fresh seedlings for your own garden. Indulge in tropical bliss with our range of passion fruit products. Taste the sunshine, right at your fingertips!',
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                        fontColor: AppColors.menuTextColor),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                width: double.maxFinite,
                margin: const EdgeInsets.all(30),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: AppColors.buttonsColor,
                    borderRadius: BorderRadius.circular(30)),
                child: Center(
                  child: MyTextWidget(
                      myText: 'BACK',
                      fontSize: 18.0,
                      fontWeight: FontWeight.w900,
                      fontColor: AppColors.menuTextColor),
                ),
              ),
            ),Expanded(child: Container()),
            GestureDetector(
              onTap: () {
                // Delete token from shared preferences
                SharedPreferences.getInstance().then((prefs) {
                  prefs.remove('token');
                  prefs.remove('userId');
                  prefs.remove('userEmail');
                  prefs.remove('username');
                  prefs.remove('location');
                  Get.to(()=>const AuthProvider());
                  // Navigate back to the previous screen
                  // Get.back();
                });
              },
              child: Container(
                width: double.maxFinite,
                margin: const EdgeInsets.all(30),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: AppColors.buttonsColor,
                    borderRadius: BorderRadius.circular(30)),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MyTextWidget(
                          myText: 'LOGOUT',
                          fontSize: 18.0,
                          fontWeight: FontWeight.w900,
                          fontColor: AppColors.menuTextColor),
                      const Icon(Icons.logout_outlined)
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
