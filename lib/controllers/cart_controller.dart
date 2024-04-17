import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/cart_model.dart';

class CartController extends GetxController {
  RxList<CartItem> cartItems = <CartItem>[].obs;
  RxBool isLoading = false.obs;

  void addToCart(int userId, int productId, int quantity) async {
    cartItems.add(
        CartItem(userId: userId, productId: productId, quantity: quantity));
    isLoading.value = true;
    await _addToCartInDatabase(
        userId, productId, quantity); // Make network call
    isLoading.value = false;
  }

  void removeFromCart(int userId, int productId) async {
    cartItems.removeWhere(
        (item) => item.userId == userId && item.productId == productId);
    isLoading.value = true;
    await _removeFromCartInDatabase(userId, productId); // Make network call
    isLoading.value = false;
  }

  Future<void> _addToCartInDatabase(
      int userId, int productId, int quantity) async {
    Uri url = Uri.parse('https://jay.john-muinde.com/add_to_cart.php');
    var response = await http.post(url, body: {
      'user_id': userId.toString(),
      'product_id': productId.toString()
    });

    if (response.statusCode == 200) {
      print('Item added to cart successfully');
      print(response.body);
    } else {
      print('Failed to add item to cart');
    }
  }

  Future<void> _removeFromCartInDatabase(int userId, int productId) async {
    Uri url = Uri.parse('https://jay.john-muinde.com/delete_from_cart.php');
    var response = await http.post(url, body: {
      'user_id': userId.toString(),
      'product_id': productId.toString()
    });

    if (response.statusCode == 200) {
      print('Item removed from cart successfully');
    } else {
      print('Failed to remove item from cart');
      print(response.body);
    }
  }
}
