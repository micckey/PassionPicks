import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passion_picks/config/style.dart';
import '../controllers/cart_controller.dart';

class CartIcon extends StatelessWidget {
  final int userId;
  final int productId;

  const CartIcon({Key? key, required this.userId, required this.productId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final controller = Get.find<CartController>();
        final isInCart = controller.cartItems.any(
            (item) => item.userId == userId && item.productId == productId);
        return IconButton(
          icon: Icon(
            isInCart ? Icons.shopping_cart : Icons.shopping_cart_outlined,
            color: isInCart ? AppColors.highlightsColor : Colors.white,
            size: 35,
          ),
          onPressed: () {
            if (!controller.isLoading.value) {
              if (isInCart) {
                controller.removeFromCart(userId, productId);
              } else {
                controller.addToCart(userId, productId, 1);
              }
            }
          },
        );
      },
    );
  }
}
