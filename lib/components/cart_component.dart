import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passion_picks/config/style.dart';
import '../controllers/cart_controller.dart';
import '../models/product_model.dart'; // Import Product model

class CartIcon extends StatelessWidget {
  final Product product;
  final String? userId;

  const CartIcon({Key? key, required this.product, this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();

    return Obx(
          () {


            final isInCart = cartController.cartProducts.any((p) => p.id == product.id);


        return IconButton(
          icon: Icon(
            isInCart ? Icons.shopping_cart : Icons.shopping_cart_outlined,
            color: isInCart ? AppColors.highlightsColor : Colors.white,
            size: 35,
          ),
          onPressed: () {
            if (!cartController.isLoading.value) {
              if (isInCart) {
                cartController.removeFromCart(userId, product);
              } else {
                cartController.addToCart(userId, product);
              }
            }
          },
        );
      },
    );
  }
}
