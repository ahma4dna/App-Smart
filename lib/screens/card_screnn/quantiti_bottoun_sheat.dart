import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoapsmart_useers_laerm/moeals/card_models.dart';
import 'package:shoapsmart_useers_laerm/provider/card_provider.dart';

class QuantitiBottounSheat extends StatelessWidget {
  const QuantitiBottounSheat({super.key, required this.cardModels});
  final CardModels cardModels;

  @override
  Widget build(BuildContext context) {
    final cardProvider = Provider.of<CardProvider>(context);
    return Column(
      children: [
        // ignore: prefer_const_constructors
        SizedBox(
          height: 10,
        ),
        Container(
          width: 50,
          height: 6,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        // ignore: prefer_const_constructors
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  // ignore: avoid_print
                  cardProvider.updateProductToCard(
                    productId: cardModels.productId,
                    quantiti: index + 1,
                  );
                  Navigator.pop(context);
                },
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      "${index + 1}",
                      // ignore: prefer_const_constructors
                      style: TextStyle(
                        fontSize: 23,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
