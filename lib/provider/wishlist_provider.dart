import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shoapsmart_useers_laerm/moeals/wishlist_model.dart';
import 'package:shoapsmart_useers_laerm/services/mehtode_my_app.dart';

class WishlistProvider with ChangeNotifier {
  Map<String, WishListMoel> wishlistIteams = {};
  Map<String, WishListMoel> get getWishListIea => wishlistIteams;
  // bool isProductInWislist({required String productId}) {
  //   return wishlistIteams.containsKey(productId);
  // }

  void addOrRemoveWislist({required String productId}) {
    if (wishlistIteams.containsKey(productId)) {
      wishlistIteams.remove(productId);
    } else {
      wishlistIteams.putIfAbsent(
        productId,
        () => WishListMoel(
          productId: productId,
          //    id: const Uuid().v4(),
        ),
      );
    }

    notifyListeners();
  }

  void clearAllIteamWishList() {
    wishlistIteams.clear();
    notifyListeners();
  }

  //Firebase
  final userData = FirebaseFirestore.instance.collection("users");
  final auth = FirebaseAuth.instance;
  bool isProductInWislist({required String productId}) {
    return wishlistIteams.containsKey(productId);
  }

  Future<void> addOrRemoveWislistWithFirebase(
      {required String productId, required BuildContext context}) async {
    User? user = auth.currentUser;
    if (!wishlistIteams.containsKey(productId)) {
      if (user == null) {
        MehtodeMyApp.showErorrORwarnigDialog(
            context: context, subTile: "Pleass sign in", fce: () {});
        return;
      }
      try {
        userData.doc(user.uid).update({
          'userWishlist': FieldValue.arrayUnion([
            {
              "productId": productId,
            }
          ]),
        });
        await fatcWislistFirebase();
        Fluttertoast.showToast(msg: "Added To WishList");
      } catch (e) {
        rethrow;
      }
    } else {
      await removeWishListFirebase(productId: productId, context: context);
    }
  }

  Future<void> removeWishListFirebase({
    required String productId,
    required BuildContext context,
  }) async {
    User? user = auth.currentUser;
    if (user == null) {
      MehtodeMyApp.showErorrORwarnigDialog(
          context: context, subTile: "Pleass sign in", fce: () {});
      return;
    }
    try {
      await userData.doc(user.uid).update({
        'userWishlist': FieldValue.arrayRemove([
          {
            "productId": productId,
          }
        ]),
      });
      wishlistIteams.remove(productId);
      await fatcWislistFirebase();
      Fluttertoast.showToast(msg: "Removed To WishList");
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  Future<void> removeAllWishlistFirebase() async {
    try {
      User? user = auth.currentUser;
      userData.doc(user!.uid).update({"userWishlist": []});
      wishlistIteams.clear();
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  Future<void> fatcWislistFirebase() async {
    User? user = auth.currentUser;
    if (user == null) {
      wishlistIteams.clear();
      return;
    }

    try {
      final wishData = await userData.doc(user.uid).get();
      final data = wishData.data();
      final length = wishData.get('userWishlist').length;
      if (data == null || !data.containsKey('userWishlist')) {
        return;
      }

      for (int index = 0; index < length; index++) {
        wishlistIteams.putIfAbsent(
            wishData.get('userWishlist')[index]["productId"],
            () => WishListMoel(
                  productId: wishData.get('userWishlist')[index]["productId"],
                ));
      }
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }
}
