import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shoapsmart_useers_laerm/moeals/user_modeal.dart';

class UserProvider with ChangeNotifier {
  UserModeal? userModeal;
  UserModeal get getUser {
    return userModeal!;
  }

  Future<UserModeal?> fatcUserInfo() async {
    final auth = FirebaseAuth.instance;
    final User user = auth.currentUser!;
    if (user == null) {
      return null;
    }
    final id = user.uid;
    final userDoc =
        await FirebaseFirestore.instance.collection("users").doc(id).get();
    final userDocData = userDoc.data();

    try {
      userModeal = UserModeal(
        userId: userDocData!.containsKey("userId") ? userDoc.get("userId") : "",
        userImage: userDocData.containsKey("userImage")
            ? userDoc.get("userImage")
            : "",
        userName:
            userDocData.containsKey("userName") ? userDoc.get("userName") : "",
        userEmail: userDocData.containsKey("userEmail")
            ? userDoc.get("userEmail")
            : "",
        createdAt: userDoc.get("createdAt"),
        userCart:
            userDocData.containsKey("userCart") ? userDoc.get("userCart") : [],
        userWishlist: userDocData.containsKey("userWishlist")
            ? userDoc.get("userWishlist")
            : [],
      );
      return userModeal;
    } on FirebaseException catch (erorr) {
      throw erorr.message.toString();
    } catch (eroor) {
      rethrow;
    }
  }
}
