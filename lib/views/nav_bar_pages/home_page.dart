import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:passion_picks/config/style.dart';
import '../../config/custom_widgets.dart';
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
          return Center(
              child: MyTextWidget(
            myText: 'Experiencing trouble fetching data \u{1F615}',
            fontSize: 18.0,
            fontWeight: FontWeight.normal,
            fontColor: AppColors.menuTextColor,
          ));
        } else if (snapshot.hasData) {
          final products = snapshot.data!;
          return HomePageContent(
            products: products,
            userId: userId,
          );
        } else {
          return MyTextWidget(
            myText: 'No Products available \u{1F636}',
            fontSize: 18.0,
            fontWeight: FontWeight.normal,
            fontColor: AppColors.menuTextColor,
          );
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
