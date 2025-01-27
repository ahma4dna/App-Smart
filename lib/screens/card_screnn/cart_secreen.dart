// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoapsmart_useers_laerm/provider/card_provider.dart';
import 'package:shoapsmart_useers_laerm/screens/card_screnn/bottoun_chwakOut.dart';
import 'package:shoapsmart_useers_laerm/screens/card_screnn/card_widget.dart';
import 'package:shoapsmart_useers_laerm/services/image_manger.dart';
import 'package:shoapsmart_useers_laerm/widgets/empty_bag.dart';
import 'package:shoapsmart_useers_laerm/widgets/title_text.dart';

import '../../services/mehtode_my_app.dart';

class CartSecreen extends StatefulWidget {
  const CartSecreen({super.key});

  @override
  State<CartSecreen> createState() => _CartSecreenState();
}

class _CartSecreenState extends State<CartSecreen> {
  @override
  Widget build(BuildContext context) {
    final cardProvider = Provider.of<CardProvider>(context);
    bool isEmptey = false;
    return cardProvider.getCardIea.isEmpty
        ? Scaffold(
            body: EmptyBag(
                title: 'Whoops!',
                subTitle: 'Your cart is empty',
                imagePthe: AssetsManager.shoppingBasket,
                bodytext:
                    'Loocks Like you didint add anything yet to your cart \ngo and start shoping now',
                textBootun: 'Shop Now'),
          )
        : Scaffold(
            bottomSheet: BottounChwakout(),
            appBar: AppBar(
              title:
                  TitleText(lable: 'Cart(${cardProvider.getCardIea.length})'),
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
                        subTile: "Clear All Itemas",
                        fce: () async {
                          //  cardProvider.clearAllIteam();
                          await cardProvider.clearAllIteamCardFirbase();
                        });
                  },
                  icon: const Icon(
                    Icons.delete_forever,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) =>
                        ChangeNotifierProvider.value(
                            value: cardProvider.getCardIea.values
                                .toList()
                                .reversed
                                .toList()[index],
                            child: const CardWidget()),
                    itemCount: cardProvider.cardIteams.length,
                  ),
                ),
                SizedBox(
                  height: kBottomNavigationBarHeight + 20,
                ),
              ],
            ),
          );
  }
}
