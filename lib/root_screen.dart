import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoapsmart_useers_laerm/provider/card_provider.dart';
import 'package:shoapsmart_useers_laerm/provider/product_provider.dart';
import 'package:shoapsmart_useers_laerm/provider/theam_provider.dart';
import 'package:shoapsmart_useers_laerm/provider/wishlist_provider.dart';
import 'package:shoapsmart_useers_laerm/screens/card_screnn/cart_secreen.dart';
import 'package:shoapsmart_useers_laerm/screens/home_screen.dart';
import 'package:shoapsmart_useers_laerm/screens/profile_screen.dart';
import 'package:shoapsmart_useers_laerm/screens/saerch_screen.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class RootScreen extends StatefulWidget {
  static String routName = "RootScreen";

  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int couantPage = 0;
  late PageController controller;
  bool isLoading = true;
  List<Widget> screens = [
    const HomeScreen(),
    SaerchScreen(),
    const CartSecreen(),
    const ProfileScreen(),
  ];
  Future<void> fatchDataProduct() async {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    final cardProvider = Provider.of<CardProvider>(context, listen: false);
        final wishlistProvider = Provider.of<WishlistProvider>(context,listen: false);


    try {
      Future.wait(
        {
          ///awiating any future to complete
          productProvider.featcProducts(),
        },
      );

          Future.wait(
        {
        
          cardProvider.featchCardFromFirebase(),
        },
      );
        Future.wait(
        {
      
          wishlistProvider.fatcWislistFirebase(),
        },
      );
    } catch (e) {
      log(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    controller = PageController(
      initialPage: couantPage,
    );
  }

  @override
  void didChangeDependencies() {
    if (isLoading) {
      fatchDataProduct();
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final cardProvider = Provider.of<CardProvider>(context);
    final isDark = TheamProvider.get(context).getIsDarkTheam;
    return Scaffold(
      body: PageView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        children: screens,
      ),
      bottomNavigationBar: NavigationBar(
        indicatorColor: isDark ? Colors.blueGrey : Colors.blue[100],
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        selectedIndex: couantPage,
        onDestinationSelected: (int index) {
          setState(() {
            couantPage = index;
          });
          controller.jumpToPage(couantPage);
        },
        destinations: [
          const NavigationDestination(
            icon: Icon(
              IconlyLight.home,
            ),
            selectedIcon: Icon(IconlyBold.home),
            label: 'Home',
          ),
          const NavigationDestination(
            icon: Icon(
              IconlyLight.search,
            ),
            selectedIcon: Icon(IconlyBold.search),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Badge(
              label: Text(
                cardProvider.getCardIea.length.toString(),
                style: const TextStyle(color: Colors.white),
              ),
              isLabelVisible: true,
              backgroundColor: Colors.red,
              child: const Icon(
                IconlyLight.bag2,
              ),
            ),
            selectedIcon: const Icon(IconlyBold.bag2),
            label: 'Cart',
          ),
          const NavigationDestination(
            icon: Icon(
              IconlyLight.profile,
            ),
            selectedIcon: Icon(IconlyBold.profile),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
