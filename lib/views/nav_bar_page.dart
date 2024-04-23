import 'package:flutter/material.dart';
import 'package:passion_picks/config/custom_widgets.dart';
import 'package:passion_picks/config/style.dart';
import 'package:passion_picks/views/dashboard_drawer.dart';
import 'package:passion_picks/views/nav_bar_pages/history_page.dart';
import 'package:passion_picks/views/nav_bar_pages/home_page.dart';
import 'nav_bar_pages/cart_page.dart';
import 'nav_bar_pages/wishlist_page.dart';

class NavBarPage extends StatefulWidget {

  final String? userId;
  final String? userEmail;
  final String? username;
  final String? location;


  const NavBarPage({super.key, required this.userId, required this.userEmail, required this.username, required this.location});

  @override
  State<NavBarPage> createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage> {
  PageController pageController = PageController(initialPage: 1);
  int currentIndex = 1;
  List imagePath = [
    'assets/icons/history.png',
    'assets/icons/home_icon.png',
    'assets/icons/cart.png',
    'assets/icons/wishlist.png'
  ];



  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 1);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.buttonsColor,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: AppColors.buttonsColor,
        automaticallyImplyLeading: false,
        leading: Builder(builder: (context) {
          return GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: Icon(
              Icons.menu,
              color: AppColors.titlesTextColor,
              size: 30,
            ),
          );
        }),
        flexibleSpace: SizedBox(
          height: double.maxFinite,
          width: double.maxFinite,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 70, right: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyTextWidget(
                      myText: 'Welcome, ${widget.username} \u{1F44B}',
                      fontSize: 20.0,
                      fontWeight: FontWeight.w900,
                      fontColor: AppColors.menuTextColor),
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(45),
                        image: const DecorationImage(
                            image: AssetImage(
                              'assets/images/akaza.jpg',
                            ),
                            fit: BoxFit.fill),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black54,
                              blurRadius: 10,
                              offset: Offset(0.5, 0.5),
                              spreadRadius: 2)
                        ]),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      drawer: const DashBoardDrawer(),
      body: Stack(children: [
        Positioned.fill(
          // bottom: 100,
          child: PageView(
            physics: const BouncingScrollPhysics(),
            controller: pageController,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            children: [
              HistoryPage(
                userId: widget.userId,
              ),
              HomePage(
                userId: widget.userId,
              ),
              CartPage(
                userId: widget.userId,
              ),
              WishListPage(
                userId: widget.userId,
              )
            ],
          ),
        ),
        Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              width: double.maxFinite,
              height: 75,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  color: AppColors.primaryBackgroundColor),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(4, (navIndex) {
                    return Expanded(
                      child: CustomNavBarIcons(
                        index: navIndex,
                        onTapMethod: () {
                          pageController.animateToPage(navIndex,
                              duration: const Duration(microseconds: 1000),
                              curve: Curves.ease);
                        },
                        imagePath: imagePath[navIndex],
                        isActive: currentIndex == navIndex ? true : false,
                      ),
                    );
                  })),
            ))
      ]),
    );
  }
}
