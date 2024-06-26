import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:passion_picks/config/style.dart';
import 'package:passion_picks/controllers/wishlist_controller.dart';
import '../../config/custom_widgets.dart';
import '../product_view_page.dart';

class WishListPage extends StatefulWidget {
  final String? userId;

  const WishListPage({super.key, this.userId});

  @override
  State<WishListPage> createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  final WishListController wishlistController = Get.find<WishListController>();

  @override
  void initState() {
    super.initState();
    wishlistController.fetchWishlistProducts(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      body: Obx(() {
        if (wishlistController.isLoading.value) {
          return Center(
            child: LoadingAnimationWidget.fourRotatingDots(
              color: AppColors.secondaryBackgroundColor,
              size: 80,
            ),
          );
        } else {
          if (wishlistController.wishlistProducts.isEmpty) {
            return Center(
              child: MyTextWidget(
                myText: 'No items in wishlist \u{1F636}',
                fontSize: 18.0,
                fontWeight: FontWeight.normal,
                fontColor: AppColors.menuTextColor,
              ),
            );
          } else {
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: wishlistController.wishlistProducts.length,
              itemBuilder: (context, index) {
                final product = wishlistController.wishlistProducts[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(() => ProductViewPage(
                        product: product, userId: widget.userId));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColors.cardsColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
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
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyTextWidget(
                              myText: product.name,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                              fontColor: AppColors.menuIconsColor,
                            ),
                            MyTextWidget(
                              myText: 'Ksh${product.price}',
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700,
                              fontColor: AppColors.menuIconsColor,
                            ),
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
                                    'Do you want to remove item from WishList?',
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                fontColor: AppColors.menuTextColor,
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Get.back(),
                                  child: MyTextWidget(
                                    myText: 'cancel',
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w900,
                                    fontColor: AppColors.menuIconsColor,
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    wishlistController.removeFromWishList(
                                        widget.userId, product);
                                    wishlistController.update();
                                    Get.back();
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        AppColors.cardsColor),
                                  ),
                                  child: MyTextWidget(
                                    myText: 'Yes',
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w900,
                                    fontColor: AppColors.menuIconsColor,
                                  ),
                                ),
                              ],
                            );
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
      }),
    );
  }
}
