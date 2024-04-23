import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passion_picks/components/wishlist_component.dart';
import 'package:passion_picks/config/style.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config/custom_widgets.dart';
import '../controllers/cart_controller.dart';
import '../models/product_model.dart';
import '../models/transaction_model.dart';

class ProductViewPage extends StatefulWidget {
  final Product product;
  final String? userId;

  const ProductViewPage({super.key, required this.product, this.userId});

  @override
  State<ProductViewPage> createState() => _ProductViewPageState();
}

class _ProductViewPageState extends State<ProductViewPage> {
  //Set Item Quantity
  int itemQuantity = 1;

  //Add Transaction
  Future<String> addTransaction(Transaction transaction) async {
    // Define your API endpoint
    String apiUrl = 'http://jay.john-muinde.com/add_transaction.php';

    // Create a JSON object containing the transaction data
    Map<String, dynamic> data = {
      'user_id': transaction.userId,
      'product_id': transaction.productId,
      'quantity': transaction.quantity,
    };

    // Send a POST request to the API endpoint
    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        body: data,
      );

      // Check the response status code
      if (response.statusCode == 200) {
        // Parse the JSON response
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        // Check if the transaction was successfully added
        if (jsonResponse['status'] == 'success') {
          // Transaction added successfully
          return 'Success';
          // Get.back();
        } else {
          // Failed to add transaction
          print('Failed to add transaction: ${jsonResponse['message']}');
        }
      } else {
        // Handle non-200 status code
        print(
            'Failed to add transaction. Server returned status: ${response.statusCode}');
      }
    } catch (error) {
      // Handle any errors that occur during the HTTP request
      // return 'Error';
      print('Error adding transaction: $error');
    }
    return 'Error';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      body: SafeArea(
          child: Center(
              child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: AppColors.buttonsColor,
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: Image.asset(
                      'assets/icons/arrow_back.png',
                      height: 30,
                      width: 35,
                    )),
              ),
              Expanded(child: Container()),
              WishListIcon(
                product: widget.product,
                isProductPage: true,
                userId: widget.userId,
              ),
              const SizedBox(
                width: 20,
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            width: double.maxFinite,
            height: 350,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset(
                  widget.product.image,
                  fit: BoxFit.fill,
                )),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: MyTextWidget(
                myText: widget.product.name,
                fontSize: 22.0,
                fontWeight: FontWeight.w900,
                fontColor: AppColors.menuTextColor),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 130,
                  height: 55,
                  decoration: BoxDecoration(
                      color: AppColors.cardsColor.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(50)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        child: const Icon(
                          Icons.remove_circle_outlined,
                          color: Colors.white,
                          size: 45,
                        ),
                        onTap: () {
                          itemQuantity == 1
                              ? null
                              : setState(() {
                                  itemQuantity--;
                                });
                        },
                      ),
                      MyTextWidget(
                          myText: itemQuantity.toString(),
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          fontColor: AppColors.menuTextColor),
                      GestureDetector(
                        child: const Icon(
                          Icons.add_circle_outlined,
                          color: Colors.white,
                          size: 45,
                        ),
                        onTap: () {
                          setState(() {
                            itemQuantity++;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    MyTextWidget(
                        myText: 'Ksh',
                        fontSize: 25.0,
                        fontWeight: FontWeight.w900,
                        fontColor: AppColors.titlesTextColor),
                    Padding(
                      padding: const EdgeInsets.only(right: 25),
                      child: MyTextWidget(
                          myText: (double.parse(widget.product.price) *
                                  itemQuantity)
                              .toString(),
                          fontSize: 30.0,
                          fontWeight: FontWeight.w900,
                          fontColor: AppColors.titlesTextColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: MyTextWidget(
                myText: widget.product.description,
                fontSize: 16.0,
                fontWeight: FontWeight.w900,
                fontColor: AppColors.menuTextColor),
          ),
          Expanded(child: Container()),
          GestureDetector(
            onTap: () {
              Get.defaultDialog(
                  backgroundColor: AppColors.feedbackColor,
                  title: 'Purchase ${widget.product.name}',
                  content: MyTextWidget(
                      myText:
                          'Proceed with payment of: Ksh${int.parse(widget.product.price) * itemQuantity}',
                      fontSize: 18.0,
                      fontWeight: FontWeight.w900,
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
                        // Check if the item is in the cart
                        final cartController = Get.find<CartController>();
                        final isInCart = cartController.cartProducts
                            .contains(widget.product);

                        // Create a Transaction object with appropriate values
                        Transaction transaction = Transaction(
                          userId: widget.userId,
                          productId: widget.product.id,
                          quantity: itemQuantity.toString(),
                        );

                        // Call the addTransaction function with the Transaction object
                        addTransaction(transaction).then((value) {
                          Get.back(); // Close the dialog
                          if (isInCart) {
                            // If the item is in the cart, remove it after the transaction is completed
                            cartController.removeFromCart(
                                widget.userId, widget.product);
                          }
                          value == 'Success'
                              ? buildSnackBar(
                                  'Success',
                                  'Payment made Successfully',
                                  AppColors.cardsColor)
                              : buildSnackBar(
                                  'Error',
                                  'An Unexpected Error occurred',
                                  AppColors.feedbackColor);
                        });
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(AppColors.cardsColor)),
                      child: MyTextWidget(
                          myText: 'Yes',
                          fontSize: 16.0,
                          fontWeight: FontWeight.w900,
                          fontColor: AppColors.menuIconsColor),
                    )
                  ]);
            },
            child: Container(
              width: double.maxFinite,
              margin: const EdgeInsets.symmetric(horizontal: 15),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: AppColors.buttonsColor),
              child: Center(
                child: MyTextWidget(
                    myText: 'Make Order',
                    fontSize: 30.0,
                    fontWeight: FontWeight.w900,
                    fontColor: AppColors.menuIconsColor),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ))),
    );
  }
}
