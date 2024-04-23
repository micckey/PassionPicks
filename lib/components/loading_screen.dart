

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../config/style.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Expanded(child: Container(
      color: AppColors.feedbackColor,
      child: Center(
        child: LoadingAnimationWidget.fourRotatingDots(
            color: AppColors.secondaryBackgroundColor, size: 80),
      ),
    ));
  }
}
