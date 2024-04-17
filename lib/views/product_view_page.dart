import 'package:flutter/material.dart';
import 'package:passion_picks/config/style.dart';

import '../config/custom_widgets.dart';

class ProductViewPage extends StatefulWidget {
  const ProductViewPage({super.key});

  @override
  State<ProductViewPage> createState() => _ProductViewPageState();
}

class _ProductViewPageState extends State<ProductViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      body: Center(child: MyTextWidget(myText: 'Product View', fontSize: 20.0, fontWeight: FontWeight.w900, fontColor: AppColors.menuTextColor)),
    );
  }
}
