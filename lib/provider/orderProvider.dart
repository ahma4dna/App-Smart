import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shoapsmart_useers_laerm/moeals/order_moel.dart';

class Orderprovider with ChangeNotifier {
  List<OrdersModelAdvanced> order = [];
  List<OrdersModelAdvanced> get getOrder => order;
  Future<List<OrdersModelAdvanced>> featchOrder() async {
    try {
    await  FirebaseFirestore.instance.collection("orders").get().then(
        (orderSnapshot) {
          order.clear();
          for (var element in orderSnapshot.docs) {
            order.insert(
                0,
                OrdersModelAdvanced(
                  orderId: element.get("orderId"),
                  userId: element.get("userId"),
                  productId: element.get("productId"),
                  productTitle: element.get("productTitle"),
                  userName: element.get("userName"),
                  price: element.get("price").toString(),
                  imageUrl: element.get("imageUrl"),
                  quantity: element.get("quantity").toString(),
                  orderDate: element.get("orderDate"),
                ));
          }
        },
      );
    
      return order;
      
    } catch (e) {
      rethrow;
    }
  }
    notifyListeners();
}
