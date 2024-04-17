import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:passion_picks/models/wishlist_model.dart';

class WishListController extends GetxController {
  RxList<WishlistItem> wishlistItems = <WishlistItem>[].obs;
  RxBool isLoading = false.obs;

  void toggleLoading(bool value) {
    isLoading.value = value;
  }

  Future<void> addToWishList(String userId, String productId) async {
    try {
      toggleLoading(true); // Set loading state to true
      // Make network call
      final response = await http.post(
        Uri.parse('https://jay.john-muinde.com/add_to_wishlist.php'),
        body: {'user_id': userId, 'product_id': productId},
      );
      if (response.statusCode == 200) {
        print('Item added to wishlist successfully');
        print(response);
        // Add item to local list if needed
        wishlistItems.add(WishlistItem(userId: userId, productId: productId));
      } else {
        print('Failed to add item to wishlist');
        print(response);
      }
    } finally {
      toggleLoading(false); // Set loading state to false
    }
  }

  Future<void> removeFromWishList(String userId, String productId) async {
    try {
      toggleLoading(true); // Set loading state to true
      // Make network call
      final response = await http.post(
        Uri.parse('https://jay.john-muinde.com/delete_from_wishlist.php'),
        body: {'user_id': userId, 'product_id': productId},
      );
      if (response.statusCode == 200) {
        print('Item removed from wishlist successfully');
        // Remove item from local list if needed
        wishlistItems.removeWhere(
            (item) => item.userId == userId && item.productId == productId);
      } else {
        print('Failed to remove item from wishlist');
      }
    } finally {
      toggleLoading(false); // Set loading state to false
    }
  }
}
