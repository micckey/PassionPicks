import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passion_picks/config/style.dart';
import 'package:passion_picks/controllers/wishlist_controller.dart';

import '../models/product_model.dart';

class WishListIcon extends StatelessWidget {
  final Product product;
  final bool isProductPage;

  final String? userId;

  const WishListIcon({
    super.key,
    required this.product,
    this.isProductPage = false,
    this.userId,
  });

  @override
  Widget build(BuildContext context) {
    final wishlistController = Get.find<WishListController>();

    return Obx(
      () {
        final isInWishList =
            wishlistController.wishlistProducts.any((p) => p.id == product.id);

        return IconButton(
          icon: Icon(
            isInWishList ? Icons.favorite : Icons.favorite_border_outlined,
            color: isInWishList
                ? AppColors.highlightsColor
                : isProductPage
                    ? Colors.black
                    : Colors.white,
            size: 35,
          ),
          onPressed: () {
            if (!wishlistController.isLoading.value) {
              if (isInWishList) {
                wishlistController.removeFromWishList(userId, product);
              } else {
                wishlistController.addToWishList(userId, product);
              }
            }
          },
        );
      },
    );
  }
}
