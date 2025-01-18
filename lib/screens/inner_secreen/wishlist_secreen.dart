// ignore_for_file: dead_code

import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoapsmart_useers_laerm/provider/wishlist_provider.dart';
import 'package:shoapsmart_useers_laerm/services/image_manger.dart';
import 'package:shoapsmart_useers_laerm/services/mehtode_my_app.dart';
import 'package:shoapsmart_useers_laerm/widgets/empty_bag.dart';
import 'package:shoapsmart_useers_laerm/widgets/product/product_widget.dart';
import 'package:shoapsmart_useers_laerm/widgets/title_text.dart';

class WishlistSecreen extends StatefulWidget {
  static const routeName = 'WishlistSecreen';
  const WishlistSecreen({super.key});

  @override
  State<WishlistSecreen> createState() => _WishlistSecreenState();
}

class _WishlistSecreenState extends State<WishlistSecreen> {
  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);

    return wishlistProvider.getWishListIea.isEmpty
        ? Scaffold(
            body: EmptyBag(
                title: 'Whoops!',
                subTitle: 'Your cart is empty',
                imagePthe: AssetsManager.wishlistSvg,
                bodytext:
                    'Loocks Like you didint add anything yet to your cart \ngo and start shoping now',
                textBootun: 'Shop Now'),
          )
        : Scaffold(
            appBar: AppBar(
              title:  TitleText(lable: 'Wishlist(${wishlistProvider.getWishListIea.length})'),
              leading: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Image(
                  image: AssetImage(AssetsManager.shoppingCart),
                  fit: BoxFit.cover,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    MehtodeMyApp.showErorrORwarnigDialog(
                        isErorr: false,
                        context: context,
                        subTile: "Clear All WishList",
                        fce: () {
                          wishlistProvider.clearAllIteamWishList();
                        });
                  },
                  icon: const Icon(
                    Icons.delete_forever,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            body: DynamicHeightGridView(
              builder: (context, index) => ProductWidget(
                productId: wishlistProvider.getWishListIea.values
                    .toList()[index]
                    .productId,
              ),
              itemCount: wishlistProvider.getWishListIea.length,
              crossAxisCount: 2,
            ),
          );
  }
}
