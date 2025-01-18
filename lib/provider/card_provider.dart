import 'package:flutter/material.dart';
import 'package:shoapsmart_useers_laerm/moeals/card_models.dart';
import 'package:shoapsmart_useers_laerm/moeals/product_mosel.dart';
import 'package:shoapsmart_useers_laerm/provider/product_provider.dart';
import 'package:uuid/uuid.dart';

class CardProvider with ChangeNotifier {
  Map<String, CardModels> cardIteams = {};
  Map<String, CardModels> get getCardIea => cardIteams;
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
