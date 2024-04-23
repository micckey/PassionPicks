import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passion_picks/components/cart_component.dart';
import 'package:passion_picks/components/wishlist_component.dart';
import 'package:passion_picks/config/custom_widgets.dart';
import 'package:passion_picks/config/style.dart';
import 'package:passion_picks/views/product_view_page.dart';
import '../../models/product_model.dart';

class HomePageContent extends StatefulWidget {
  final List<Product> products;

  final String? userId;

  const HomePageContent({super.key, required this.products, this.userId});

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  final PageController _pageController = PageController(
    initialPage: 0,
  );
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    //Define the Image Slider widget
    Widget buildImageSlider(Product product, {required bool isSlider}) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: GestureDetector(
          onTap: () {
            Get.to(() => ProductViewPage(
                  product: product,
                  userId: widget.userId,
                ));
          },
          child: Stack(
            children: <Widget>[
              Image.asset(
                product.image,
                fit: BoxFit.fill,
                width: 1000.0,
              ),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(200, 0, 0, 0),
                        Color.fromARGB(0, 0, 0, 0)
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MyTextWidget(
                          myText: product.name,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          fontColor: Colors.white),
                      isSlider
                          ? const SizedBox.shrink()
                          : MyTextWidget(
                              myText: 'Ksh${product.price.toString()}',
                              fontSize: 25.0,
                              fontWeight: FontWeight.w900,
                              fontColor: AppColors.titlesTextColor),
                    ],
                  ),
                ),
              ),
              isSlider
                  ? const SizedBox.shrink()
                  : Positioned(
                      top: 10,
                      right: 20,
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: const LinearGradient(
                            colors: [
                              Color.fromARGB(160, 0, 0, 0),
                              Color.fromARGB(50, 0, 0, 0)
                            ],
                            begin: Alignment.topRight,
                            end: Alignment.topCenter,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              WishListIcon(
                                product: product,
                                userId: widget.userId,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              CartIcon(
                                product: product,
                                userId: widget.userId,
                              )
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

    //Carousel Slider
    final List<Widget> imageSliders = widget.products
        .where((product) =>
            int.parse(product.id) != 1 && int.parse(product.id) != 101)
        .take(4)
        .map((product) => buildImageSlider(product, isSlider: true))
        .toList();
    //Page View Slider
    final List<Widget> pageViewSliders = widget.products
        .where((product) => int.parse(product.id) != 101)
        .map((product) => buildImageSlider(product, isSlider: false))
        .toList();

    //Seedling
    final Product seedling = widget.products.firstWhere(
        (product) => product.id == 101.toString(),
        orElse: () => Product(
            id: 101.toString(),
            name: '',
            description: '',
            price: 0.toString(),
            image: ''));

    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              Center(
                child: MyTextWidget(
                    myText: 'Your daily dose of Passion \u{1F525}',
                    fontSize: 17.0,
                    fontWeight: FontWeight.w900,
                    fontColor: AppColors.cardsColor),
              ),
              const SizedBox(
                height: 10,
              ),
              MyTextWidget(
                  myText: 'Daily Specials',
                  fontSize: 20.0,
                  fontWeight: FontWeight.w900,
                  fontColor: AppColors.menuTextColor),
              const SizedBox(
                height: 5,
              ),
              CarouselSlider(
                options: CarouselOptions(
                  height: 200,
                  autoPlay: true,
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                ),
                items: imageSliders,
              ),
              const SizedBox(
                height: 10,
              ),
              MyTextWidget(
                  myText: 'Popular Products',
                  fontSize: 20.0,
                  fontWeight: FontWeight.w900,
                  fontColor: AppColors.menuTextColor),
              const SizedBox(
                height: 5,
              ),
              Column(
                children: [
                  SizedBox(
                    height: 230,
                    width: double.maxFinite,
                    child: PageView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      controller: _pageController,
                      itemCount: pageViewSliders.length,
                      // Use imageSliders length
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: pageViewSliders[index],
                        ); // Return each imageSlider
                      },
                      onPageChanged: (index) {
                        setState(() {
                          _currentPageIndex = index;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      pageViewSliders.length, // Use imageSliders length
                      (index) => Container(
                        margin: index == _currentPageIndex
                            ? const EdgeInsets.all(3)
                            : const EdgeInsets.all(1.5),
                        width: index == _currentPageIndex ? 15 : 10,
                        height: index == _currentPageIndex ? 10 : 10,
                        decoration: BoxDecoration(
                          color: index == _currentPageIndex
                              ? Colors.grey
                              : Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              MyTextWidget(
                  myText: 'Buy seedlings',
                  fontSize: 20.0,
                  fontWeight: FontWeight.w900,
                  fontColor: AppColors.menuTextColor),
              const SizedBox(
                height: 5,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => ProductViewPage(
                        product: seedling,
                        userId: widget.userId,
                      ));
                },
                child: Container(
                  height: 180,
                  width: double.maxFinite,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.asset(
                            seedling.image,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: const LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              MyTextWidget(
                                  myText: seedling.name,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  fontColor: Colors.white),
                              MyTextWidget(
                                  myText: 'Ksh${seedling.price.toString()}',
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.w900,
                                  fontColor: AppColors.titlesTextColor),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 100)
            ],
          ),
        ),
      )),
    );
  }
}
