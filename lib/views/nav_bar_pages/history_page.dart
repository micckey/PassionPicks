import 'package:flutter/material.dart';
import 'package:passion_picks/config/style.dart';

import '../../config/custom_widgets.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      body: Center(child: MyTextWidget(myText: 'History', fontSize: 20.0, fontWeight: FontWeight.w900, fontColor: AppColors.menuTextColor)),
    );
  }
}
