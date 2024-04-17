import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:passion_picks/config/style.dart';

class CartPage extends StatelessWidget {
  const CartPage({
    super.key,
  });

  Future<List<dynamic>> _fetchCartItems() async {
    final response = await http
        .get(Uri.parse('https://jay.john-muinde.com/view_cart.php?user_id=2'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      // Handle errors
      throw Exception('Failed to load cart items');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      body: FutureBuilder<List<dynamic>>(
        future: _fetchCartItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<dynamic> cartItems = snapshot.data!;
            return ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final cartItem = cartItems[index];
                return ListTile(
                  title: Text(cartItem['name']),
                  // Assuming 'name' is a field in your 'products' table
                  subtitle: Text(cartItem['description']),
                  // Assuming 'description' is a field in your 'products' table
                  trailing:
                      Text('${cartItem['price']}'), // Display the quantity
                );
              },
            );
          }
        },
      ),
    );
  }
}
