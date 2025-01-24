import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserModeal with ChangeNotifier{
  final String userId, userImage, userName, userEmail;
  final Timestamp createdAt;
  final List userCart, userWishlist;

  UserModeal(
      {required this.userId,
      required this.userImage,
      required this.userName,
      required this.userEmail,
      required this.createdAt,
      required this.userCart,
      required this.userWishlist});
}
