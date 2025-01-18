import 'package:flutter/material.dart';
import 'package:shoapsmart_useers_laerm/moeals/viwed_recently_models.dart';
import 'package:uuid/uuid.dart';

class ViwedRecentlyProvider with ChangeNotifier {
  Map<String, ViwedRecentlyModels> viwedrecentlyIteam = {};
  Map<String, ViwedRecentlyModels> get getViwedIea => viwedrecentlyIteam;
  bool isProductInWislist({required String productId}) {
    return viwedrecentlyIteam.containsKey(productId);
  }

  void addToHistory({required String productId}) {
    
      viwedrecentlyIteam.putIfAbsent(
        productId,
        () => ViwedRecentlyModels(
          productId: productId,
          id: const Uuid().v4(),
        ),
      );
  

    notifyListeners();
  }
  void clearAllIteamHistory() {
    viwedrecentlyIteam.clear();
    notifyListeners();
  }

}
