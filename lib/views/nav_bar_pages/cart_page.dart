import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:passion_picks/config/custom_widgets.dart';
import 'package:passion_picks/config/style.dart';
import 'package:passion_picks/views/product_view_page.dart';
import '../../controllers/cart_controller.dart';

class CartPage extends StatelessWidget {
  final String? userId;

  const CartPage({super.key, this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      body: GetBuilder<CartController>(
        builder: (cartController) {
          if (cartController.isLoading.value) {
            return Center(
                child: LoadingAnimationWidget.fourRotatingDots(
                    color: AppColors.secondaryBackgroundColor, size: 80));
          } else {
            if (cartController.cartProducts.isEmpty) {
              return Center(
                child: MyTextWidget(
                  myText: 'No items in cart',
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontColor: AppColors.menuTextColor,
                ),
              );
            } else {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: cartController.cartProducts.length,
                itemBuilder: (context, index) {
                  final product = cartController.cartProducts[index];
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => ProductViewPage(product: product));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      decoration: BoxDecoration(
                          color: AppColors.cardsColor,
                          borderRadius: BorderRadius.circular(30)),
                      width: double.maxFinite,
                      height: 100,
                      child: Row(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.asset(
                                product.image,
                                width: 100,
                                height: double.maxFinite,
                                fit: BoxFit.fill,
                              )),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyTextWidget(
                                  myText: product.name,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600,
                                  fontColor: AppColors.menuIconsColor),
                              MyTextWidget(
                                  myText: 'Ksh${product.price}',
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w700,
                                  fontColor: AppColors.menuIconsColor),
                            ],
                          ),
                          Expanded(child: Container()),
                          GestureDetector(
                            onTap: () {
                              Get.defaultDialog(
                                  backgroundColor: AppColors.feedbackColor,
                                  title: 'Alert!',
                                  content: MyTextWidget(
                                      myText:
                                      'Do you want to remove item from Cart?',
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                      fontColor: AppColors.menuTextColor),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Get.back(),
                                      child: MyTextWidget(
                                          myText: 'cancel',
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w900,
                                          fontColor: AppColors.menuIconsColor),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        cartController.removeFromCart(
                                            userId, product);
                                        cartController.update();
                                        Get.back();
                                      },
                                      style: ButtonStyle(
                                          backgroundColor:
                                          MaterialStatePropertyAll(
                                              AppColors.cardsColor)),
                                      child: MyTextWidget(
                                          myText: 'Yes',
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w900,
                                          fontColor: AppColors.menuIconsColor),
                                    )
                                  ]);
                            },
                            child: Icon(
                              Icons.delete_forever,
                              color: AppColors.feedbackColor,
                              size: 35,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}

