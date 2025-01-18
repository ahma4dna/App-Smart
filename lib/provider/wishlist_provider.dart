import 'package:flutter/material.dart';
import 'package:shoapsmart_useers_laerm/moeals/wishlist_model.dart';
import 'package:uuid/uuid.dart';

class WishlistProvider with ChangeNotifier {
  Map<String, WishListMoel> wishlistIteams = {};
  Map<String, WishListMoel> get getWishListIea => wishlistIteams;
  bool isProductInWislist({required String productId}) {
    return wishlistIteams.containsKey(productId);
  }

  void addOrRemoveWislist({required String productId}) {
    if (wishlistIteams.containsKey(productId)) {
      wishlistIteams.remove(productId);
    } else {
      wishlistIteams.putIfAbsent(
        productId,
        () => WishListMoel(
          productId: productId,
          id: const Uuid().v4(),
        ),
      );
    }

    notifyListeners();
  }

  void clearAllIteamWishList() {
    wishlistIteams.clear();
    notifyListeners();
  }
}
