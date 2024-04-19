import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passion_picks/config/style.dart';

import '../controllers/cart_controller.dart';
import '../controllers/wishlist_controller.dart';

class MyTextWidget extends StatelessWidget {
  final String myText;
  final double fontSize;
  final FontWeight fontWeight;
  final Color fontColor;

  const MyTextWidget(
      {super.key,
      required this.myText,
      required this.fontSize,
      required this.fontWeight,
      required this.fontColor});

  @override
  Widget build(BuildContext context) {
    return Text(myText,
        style: TextStyle(
            fontSize: fontSize, fontWeight: fontWeight, color: fontColor));
  }
}

class MyTextField extends StatelessWidget {
  final onChanged;

  // final ValueChanged<String>? onChanged;
  final TextEditingController controller;
  final String hintText;

  const MyTextField({
    required this.controller,
    required this.onChanged,
    required this.hintText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              color: AppColors.primaryBackgroundColor,
              blurRadius: 20,
              blurStyle: BlurStyle.outer,
              spreadRadius: 0.5,
              offset: const Offset(5, 5))
        ],
        color: Colors.white,
      ),
      child: Center(
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
              fillColor: AppColors.secondaryBackgroundColor,
              hintText: hintText,
              hintStyle: const TextStyle(
                fontSize: 16,
              ),
              contentPadding: const EdgeInsets.all(10),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none)),
        ),
      ),
    );
  }
}

class MyPasswordField extends StatelessWidget {
  final onChanged;
  final TextEditingController controller;

  final String hintText;
  bool isHidden;
  VoidCallback toggleVisibility;

  MyPasswordField({
    required this.hintText,
    required this.isHidden,
    required this.toggleVisibility,
    super.key,
    this.onChanged,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: AppColors.primaryBackgroundColor,
              blurRadius: 20,
              blurStyle: BlurStyle.outer,
              spreadRadius: 0.5,
              offset: const Offset(5, 5))
        ],
      ),
      child: Center(
        child: TextField(
          obscureText: isHidden ? false : true,
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
              suffixIcon: GestureDetector(
                  onTap: toggleVisibility,
                  child: isHidden
                      ? const Icon(CupertinoIcons.eye)
                      : const Icon(CupertinoIcons.eye_slash)),
              hintText: hintText,
              hintStyle: const TextStyle(
                fontSize: 16,
              ),
              contentPadding: const EdgeInsets.all(10),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none)),
        ),
      ),
    );
  }
}

class MyHomePageTextWidget extends StatelessWidget {
  final String myText;
  final double fontSize;
  FontWeight fontWeight;
  Color fontColor;

  MyHomePageTextWidget(
      {super.key,
      required this.myText,
      required this.fontSize,
      required this.fontWeight,
      required this.fontColor});

  @override
  Widget build(BuildContext context) {
    return Text(myText,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: fontSize, fontWeight: fontWeight, color: fontColor));
  }
}

class CustomNavBarIcons extends StatelessWidget {
  final Function onTapMethod;
  final bool isActive;
  final String imagePath;
  final int index;

  CustomNavBarIcons({
    Key? key,
    required this.onTapMethod,
    this.isActive = false,
    required this.imagePath,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final wishlistController = Get.find<WishListController>();
    final cartController = Get.find<CartController>();

    return GestureDetector(
      onTap: () {
        onTapMethod();
      },
      child: Stack(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: isActive ? AppColors.secondaryBackgroundColor : null,
              borderRadius: BorderRadius.circular(35),
            ),
            child: Center(
              child: Stack(
                children: [
                  Image.asset(
                    imagePath,
                    height: index == 1 ? 70 : 40,
                    width: index == 1 ? 70 : 40,
                    color: isActive ? AppColors.primaryBackgroundColor : null,
                  ),
                  if (index == 2)
                    Obx(() {
                      final cartController = Get.find<CartController>();
                      final cartLength = cartController.cartProducts.length;
                      return cartLength > 0
                          ? Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: AppColors.cardsColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  cartLength.toString(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          : const SizedBox.shrink();
                    }),
                  if (index == 3)
                    Obx(() {
                      final wishlistLength =
                          wishlistController.wishlistProducts.length;
                      return wishlistLength > 0
                          ? Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: AppColors.cardsColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  wishlistLength.toString(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          : const SizedBox.shrink();
                    }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

buildSnackBar(title, message, backgroundColor, [duration = 2]) {
  Get.snackbar(title, message,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      colorText: AppColors.menuTextColor,
      snackPosition: SnackPosition.TOP,
      animationDuration: Duration(seconds: duration),
      backgroundColor: backgroundColor);
}
