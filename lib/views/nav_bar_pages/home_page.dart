import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:passion_picks/config/style.dart';
import '../../models/product_model.dart';
import 'home_page_content.dart';

class HomePage extends StatelessWidget {
  final String? userId;

  const HomePage({super.key, this.userId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: fetchProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                  color: AppColors.secondaryBackgroundColor, size: 80));
        } else if (snapshot.hasError) {
          return const Center(child: Text('Experiencing trouble fetching data \u{1F615}'));
        } else if (snapshot.hasData) {
          final products = snapshot.data!;
          return HomePageContent(
            products: products,
            userId: userId,
          );
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }

  Future<List<Product>> fetchProducts() async {
    final response = await http
        .get(Uri.parse('https://jay.john-muinde.com/view_products.php'));
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Product.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
