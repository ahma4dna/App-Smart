import 'package:flutter/material.dart';

class CardModels with ChangeNotifier {
  final String productId;
  final String cardId;
  final int quantiti;
  CardModels({
    required this.productId,
    required this.cardId,
    required this.quantiti,
  });
}
