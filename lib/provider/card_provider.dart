import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shoapsmart_useers_laerm/moeals/card_models.dart';
import 'package:shoapsmart_useers_laerm/moeals/product_mosel.dart';
import 'package:shoapsmart_useers_laerm/provider/product_provider.dart';
import 'package:uuid/uuid.dart';

import '../services/mehtode_my_app.dart';

class CardProvider with ChangeNotifier {
  Map<String, CardModels> cardIteams = {};
  Map<String, CardModels> get getCardIea => cardIteams;

  ///Firebase
  final userData = FirebaseFirestore.instance.collection("users");
  final auth = FirebaseAuth.instance;
  Future<void> addCartToFirebase(
      {required String productId,
      required int quantiti,
      required BuildContext context}) async {
    User? user = auth.currentUser;
    if (user == null) {
      MehtodeMyApp.showErorrORwarnigDialog(
          context: context, subTile: "Please sign in", fce: () {});
    }
    final cardId = Uuid().v4();
    try {
      userData.doc(user!.uid).update(
        {
          "userCart": FieldValue.arrayUnion(
            [
              {
                "crdId": cardId,
                "productId": productId,
                "quantiti": quantiti,
              }
            ],
          ),
        },
      );
      Fluttertoast.showToast(msg: "Product added to cart");
    } catch (e) {
      rethrow;
    }
  }

  bool isProductIncard({required String productId}) {
    return cardIteams.containsKey(productId);
  }

  void addProductToCard({required String productId}) {
    cardIteams.putIfAbsent(
      productId,
      () => CardModels(
        productId: productId,
        cardId: const Uuid().v4(),
        quantiti: 1,
      ),
    );
    notifyListeners();
  }

  void updateProductToCard({required String productId, required int quantiti}) {
    cardIteams.update(
      productId,
      (iteam) => CardModels(
        productId: iteam.productId,
        cardId: iteam.cardId,
        quantiti: quantiti,
      ),
    );
    notifyListeners();
  }

  double getToatalProd({required ProductProvider productProvider}) {
    double total = 0.0;
    cardIteams.forEach((key, value) {
      final ProductModel? getCurntIeam =
          productProvider.findByProId(value.productId);
      if (getCurntIeam == null) {
        total += 0;
      } else {
        total += double.parse(getCurntIeam.productPrice) * value.quantiti;
      }
    });
    return total;
  }

  int getQuantit() {
    int total = 0;
    cardIteams.forEach((key, value) {
      total += value.quantiti;
    });
    return total;
  }

  void removeOneIeam({required String productId}) {
    cardIteams.remove(productId);
    notifyListeners();
  }

  void clearAllIteam() {
    cardIteams.clear();
    notifyListeners();
  }
}
