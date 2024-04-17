import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:passion_picks/config/style.dart';

class WishListPage extends StatelessWidget {
  const WishListPage({
    super.key,
  });

  Future<List<dynamic>> _fetchWishListItems() async {
    final response = await http.get(
        Uri.parse('https://jay.john-muinde.com/view_wishlist.php?user_id=2'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      // Handle errors
      throw Exception('Failed to load wishlist items');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: AppColors.primaryBackgroundColor,
      body: FutureBuilder<List<dynamic>>(
        future: _fetchWishListItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<dynamic> wishListItems = snapshot.data!;
            return ListView.builder(
              itemCount: wishListItems.length,
              itemBuilder: (context, index) {
                final wishListItem = wishListItems[index];
                return ListTile(
                  title: Text(wishListItem['name']),
                  // Assuming 'name' is a field in your 'products' table
                  subtitle: Text(wishListItem[
                      'description']), // Assuming 'description' is a field in your 'products' table
                  // Add any other fields you want to display
                );
              },
            );
          }
        },
      ),
    );
  }
}

// Usage:
// WishListPage(userId: 123), // Replace 123 with the actual user ID
