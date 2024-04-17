import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passion_picks/config/style.dart';

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
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  MyTextWidget(
                      myText: 'ABOUT',
                      fontSize: 18.0,
                      fontWeight: FontWeight.w800,
                      fontColor: AppColors.menuTextColor),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.menuTextColor.withOpacity(0.4)),
                    child: MyHomePageTextWidget(
                        myText:
                            'PASSION PICK',
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
                margin: EdgeInsets.all(30),
                padding: EdgeInsets.all(15),
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
            )
          ],
        ),
      ),
    );
  }
}
