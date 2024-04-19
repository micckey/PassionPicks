import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:passion_picks/models/wishlist_model.dart';

import '../models/product_model.dart';

class WishListController extends GetxController {
  RxList<Product> wishlistProducts = <Product>[].obs;
  RxBool isLoading = false.obs;

  late String? userId; // User ID variable

  WishListController({required this.userId});

  @override
  void onInit() {
    super.onInit();
    fetchWishlistProducts(userId); // Ensure userId is passed as a string
  }

  void fetchWishlistProducts(String? userId) async {
    isLoading.value = true;
    try {
      final response = await http.get(Uri.parse(
          'https://jay.john-muinde.com/view_wishlist.php?user_id=$userId'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        List<Product> products =
            jsonResponse.map((data) => Product.fromJson(data)).toList();
        wishlistProducts.value = products;
        print('LIST::: $products'); // Check if products are parsed correctly
      } else {
        print('Failed to fetch cart products: ${response.statusCode}');
        // Handle other HTTP status codes
      }
    } catch (e) {
      print('Error fetching cart products: $e');
      // Handle other errors
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addToWishList(userId, Product product) async {
    isLoading.value = true;

    try {
      // Make network call
      final response = await http.post(
        Uri.parse('https://jay.john-muinde.com/add_to_wishlist.php'),
        body: {'user_id': userId, 'product_id': product.id},
      );
      if (response.statusCode == 200) {
        print('Item added to wishlist successfully');
        print(response.body);
        wishlistProducts.add(product); // Update local wishlistProducts list
      } else {
        print('Failed to add item to wishlist');
        print(response);
      }
    } finally {
      isLoading.value = false; // Set loading state to false
    }
  }

  Future<void> removeFromWishList(userId, Product product) async {
    isLoading.value = true;

    try {
      // Make network call
      final response = await http.post(
        Uri.parse('https://jay.john-muinde.com/delete_from_wishlist.php'),
        body: {'user_id': userId, 'product_id': product.id},
      );
      if (response.statusCode == 200) {
        print('Item removed from wishlist successfully ${response.body}');
        wishlistProducts.remove(product); // Update local cartProducts list
      } else {
        print('Failed to remove item from wishlist');
      }
    } finally {
      isLoading.value = false; // Set loading state to false
    }
  }
}
