import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passion_picks/config/style.dart';
import 'package:passion_picks/views/auth_pages/auth_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../config/custom_widgets.dart';
import '../controllers/cart_controller.dart';
import '../controllers/wishlist_controller.dart';

class DashBoardDrawer extends StatefulWidget {
  final String? username;
  final String? email;
  final String? location;

  const DashBoardDrawer(
      {super.key,
      required this.username,
      required this.email,
      required this.location});

  @override
  State<DashBoardDrawer> createState() => _DashBoardDrawerState();
}

class _DashBoardDrawerState extends State<DashBoardDrawer> {
  final CartController cartController = Get.find<CartController>();

  final WishListController wishlistController = Get.find<WishListController>();

  final TextEditingController newUsernameController = TextEditingController();

  String? usernameText;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      usernameText = widget.username;
    });
  }

  // Function to update username
  // Function to update username
  Future<String> updateUsername() async {
    // Get the new username from the text controller
    String newUsername = newUsernameController.text.trim();
    if (newUsername.isNotEmpty && newUsername != widget.username) {
      try {
        // Make api call
        final response = await http.post(
          Uri.parse('https://jay.john-muinde.com/update_username.php'),
          body: {
            'new_username': newUsername,
            'email': widget.email,
          },
        );

        // Parse response JSON
        Map<String, dynamic> data = jsonDecode(response.body);
        if (data['code'] == 1) {
          // If update is successful, update the UI with the new username
          buildSnackBar(
            'Success',
            'Username updated successfully',
            AppColors.cardsColor,
          );
          setState(() {
            usernameText = newUsername;
          });
          SharedPreferences.getInstance().then((prefs) {
            prefs.setString('username', newUsername);
          });
          newUsernameController.clear();
          return 'success';
        } else {
          // If update fails, show error message
          buildSnackBar(
            'Error',
            'Failed to update username',
            AppColors.feedbackColor,
          );
          return 'error';
        }
      } catch (error) {
        // If an error occurs, show error message
        buildSnackBar(
          'Error',
          'Failed to update username',
          AppColors.feedbackColor,
        );
        return 'error';
      }
    } else {
      newUsernameController.clear();
      return 'error';
    }
  }

  @override
  void dispose() {
    newUsernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.primaryBackgroundColor,
      child: SafeArea(
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                  radius: 100,
                  child: Image.asset(
                    'assets/images/icon.png',
                    width: 150,
                    height: 150,
                    fit: BoxFit.contain,
                  )),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 30),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.menuTextColor.withOpacity(0.4)),
                        child: MyHomePageTextWidget(
                            myText: usernameText.toString(),
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600,
                            fontColor: AppColors.menuTextColor),
                      ),
                      GestureDetector(
                          onTap: () {
                            Get.defaultDialog(
                              title: 'Change Username',
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: newUsernameController,
                                  decoration: const InputDecoration(
                                      hintText: 'eg. Akaza'),
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Get.back(),
                                  child: const Text('Cancel'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    updateUsername().then((value) {
                                      print('VALUE:::::: $value');
                                      if (value == 'success') {
                                        Get.offAll(const AuthProvider());
                                      } else {
                                        Get.back();
                                        buildSnackBar(
                                            'Error',
                                            'Please enter a new username',
                                            AppColors.feedbackColor);
                                      }
                                    });
                                  },
                                  child: const Text('Save'),
                                ),
                              ],
                            );
                          },
                          child: const Icon(Icons.mode_edit_outline_outlined))
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MyTextWidget(
                      myText: 'ABOUT',
                      fontSize: 18.0,
                      fontWeight: FontWeight.w800,
                      fontColor: AppColors.menuTextColor),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.menuTextColor.withOpacity(0.4)),
                    child: MyHomePageTextWidget(
                        myText:
                            'Welcome to "PassionPick" – your one-stop shop for all things passion fruit! From tantalizing jams to refreshing juices, creamy ice creams to luscious cakes, and even premium oil and fresh seedlings for your own garden. Indulge in tropical bliss with our range of passion fruit products. Taste the sunshine, right at your fingertips!',
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                        fontColor: AppColors.menuTextColor),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                width: double.maxFinite,
                margin: const EdgeInsets.all(30),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: AppColors.buttonsColor,
                    borderRadius: BorderRadius.circular(30)),
                child: Center(
                  child: MyTextWidget(
                      myText: 'BACK',
                      fontSize: 18.0,
                      fontWeight: FontWeight.w900,
                      fontColor: AppColors.menuTextColor),
                ),
              ),
            ),
            Expanded(child: Container()),
            GestureDetector(
              onTap: () {
                Get.defaultDialog(
                  backgroundColor: AppColors.feedbackColor,
                  title: 'Alert!',
                  content: MyTextWidget(
                    myText: 'Are you sure you want to log out?',
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
                        // Delete token from shared preferences
                        SharedPreferences.getInstance().then((prefs) {
                          prefs.remove('token');
                          prefs.remove('userId');
                          prefs.remove('userEmail');
                          prefs.remove('username');
                          prefs.remove('location');
                          cartController.cartProducts.clear();
                          wishlistController.wishlistProducts.clear();
                          Get.offAll(() => const AuthProvider());
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.cardsColor),
                      ),
                      child: MyTextWidget(
                        myText: 'Yes',
                        fontSize: 16.0,
                        fontWeight: FontWeight.w900,
                        fontColor: AppColors.menuIconsColor,
                      ),
                    )
                  ],
                );
              },
              child: Container(
                width: double.maxFinite,
                margin: const EdgeInsets.all(30),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: AppColors.buttonsColor,
                    borderRadius: BorderRadius.circular(30)),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MyTextWidget(
                          myText: 'LOGOUT',
                          fontSize: 18.0,
                          fontWeight: FontWeight.w900,
                          fontColor: AppColors.menuTextColor),
                      const Icon(Icons.logout_outlined)
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
