import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/product_model.dart'; // Import Product model

class CartController extends GetxController {
  RxList<Product> cartProducts = <Product>[].obs;
  RxBool isLoading = false.obs;

  void fetchCartProducts(String? userId) async {
    isLoading.value = true;
    try {
      final response = await http.get(Uri.parse(
          'https://jay.john-muinde.com/view_cart.php?user_id=$userId'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        List<Product> products =
            jsonResponse.map((data) => Product.fromJson(data)).toList();
        cartProducts.value = products;
        // print('LIST::: $products'); // Check if products are parsed correctly
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

  void addToCart(userId, Product product) async {
    isLoading.value = true;
    print(userId);

    try {
      await _addToCartInDatabase(userId, product.id).then((value) =>
          cartProducts.add(
              product)); // Make network call then Update local cartProducts list
    } catch (e) {
      print('Error adding product to cart: $e');
    }
    isLoading.value = false;
  }

  void removeFromCart(userId, Product product) async {
    isLoading.value = true;
    try {
      // Make network call to remove item from cart

      await _removeFromCartInDatabase(userId, product.id).then((value) =>
          cartProducts.remove(
              product)); // Make network call then Update local cartProducts list
    } catch (e) {
      print('Error removing product from cart: $e');
    }
    isLoading.value = false;
  }

  Future<void> _addToCartInDatabase(String userId, String productId) async {
    Uri url = Uri.parse('https://jay.john-muinde.com/add_to_cart.php');
    var response = await http.post(url, body: {
      'user_id': userId.toString(),
      'product_id': productId.toString()
    });

    if (response.statusCode == 200) {
      print('Item added to cart successfully');
    } else {
      print('Failed to add item to cart');
    }
  }

  Future<void> _removeFromCartInDatabase(
      String userId, String productId) async {
    Uri url = Uri.parse('https://jay.john-muinde.com/delete_from_cart.php');
    var response = await http.post(url, body: {
      'user_id': userId.toString(),
      'product_id': productId.toString()
    });

    if (response.statusCode == 200) {
      print('Item removed from cart successfully');
    } else {
      print('Failed to remove item from cart');
    }
  }
}
