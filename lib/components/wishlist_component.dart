import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passion_picks/config/style.dart';
import 'package:passion_picks/controllers/wishlist_controller.dart';

class WishListIcon extends StatelessWidget {
  final String userId;
  final String productId;

  const WishListIcon({Key? key, required this.userId, required this.productId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final controller = Get.find<WishListController>();
        final isInWishlist = controller.wishlistItems.any(
            (item) => item.userId == userId && item.productId == productId);
        return IconButton(
          icon: Icon(
            isInWishlist ? Icons.favorite : Icons.favorite_border_outlined,
            color: isInWishlist ? AppColors.highlightsColor : Colors.white,
            size: 35,
          ),
          onPressed: () {
            if (!controller.isLoading.value) {
              if (isInWishlist) {
                controller.removeFromWishList(userId, productId);
              } else {
                controller.addToWishList(userId, productId);
              }
            }
          },
        );
      },
    );
  }
}
