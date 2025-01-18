import 'package:flutter/material.dart';

class WishListMoel  with ChangeNotifier{
  final String id;
  final String productId;

  WishListMoel({
    required this.id,
    required this.productId,
  });
}
