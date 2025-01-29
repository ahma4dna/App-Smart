// ignore_for_file: dead_code

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoapsmart_useers_laerm/provider/card_provider.dart';
import 'package:shoapsmart_useers_laerm/provider/product_provider.dart';
import 'package:shoapsmart_useers_laerm/screens/card_screnn/bottoun_chwak_out.dart';
import 'package:shoapsmart_useers_laerm/provider/user_provider.dart';
import 'package:shoapsmart_useers_laerm/screens/card_screnn/card_widget.dart';
import 'package:shoapsmart_useers_laerm/screens/loading_manger.dart';
import 'package:shoapsmart_useers_laerm/services/image_manger.dart';
import 'package:shoapsmart_useers_laerm/widgets/empty_bag.dart';
import 'package:shoapsmart_useers_laerm/widgets/title_text.dart';
import 'package:uuid/uuid.dart';

import '../../services/mehtode_my_app.dart';

class CartSecreen extends StatefulWidget {
  const CartSecreen({super.key});

  @override
  State<CartSecreen> createState() => _CartSecreenState();
}

class _CartSecreenState extends State<CartSecreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final cardProvider = Provider.of<CardProvider>(context);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);

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
            bottomSheet: BottounChwakOut(
              function: () {
                placeOrder(
                  productProvider: productProvider,
                  userProvider: userProvider,
                  cardProvider: cardProvider,
                );
              },
            ),
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
            body: LoadingManger(
              isloading: isLoading,
              chaild: Column(
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
                  const SizedBox(
                    height: kBottomNavigationBarHeight + 20,
                  ),
                ],
              ),
            ),
          );
  }

  Future<void> placeOrder({
    required ProductProvider productProvider,
    required UserProvider userProvider,
    required CardProvider cardProvider,
  }) async {
    final auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    if (user == null) {
      return;
    }
    final uId = user.uid;

    try {
      setState(() {
        isLoading = true;
      });

      cardProvider.getCardIea.forEach((key, vlue) async {
        final getProduct = productProvider.findByProId(vlue.productId);
        final orderId = Uuid().v4();
        await FirebaseFirestore.instance.collection("orders").doc(orderId).set({
          "orderId": orderId,
          "userId": uId,
          "productId": vlue.productId,
          "productTitle": getProduct!.productTitle,
          "userName": userProvider.getUser.userName,
          "price": double.parse(getProduct.productPrice) * vlue.quantiti,
          "imageUrl": getProduct.productImage,
          "quantity": vlue.quantiti,
          "totalPrice":
              cardProvider.getToatalProd(productProvider: productProvider),
          "orderDate": Timestamp.now(),
        });
        cardProvider.clearAllIteamCardFirbase();
        cardProvider.clearAllIteam();
      });
    } catch (e) {
      MehtodeMyApp.showErorrORwarnigDialog(
        context: context,
        subTile: e.toString(),
        fce: () {},
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
