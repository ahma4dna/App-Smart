import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoapsmart_useers_laerm/provider/card_provider.dart';
import 'package:shoapsmart_useers_laerm/provider/product_provider.dart';
import 'package:shoapsmart_useers_laerm/widgets/subtitle_text.dart';
import 'package:shoapsmart_useers_laerm/widgets/title_text.dart';

class BottounChwakOut extends StatelessWidget {
  const BottounChwakOut({super.key, required this.function});
  final Function function;

  @override
  Widget build(BuildContext context) {
    final cardProvider = Provider.of<CardProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    return Container(
      decoration: BoxDecoration(
          border: const Border(
            top: BorderSide(color: Colors.grey, width: 1),
          ),
          color: Theme.of(context).scaffoldBackgroundColor),
      child: SizedBox(
        height: kBottomNavigationBarHeight + 25,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // ignore: prefer_const_constructors
              //replace Expanded Widget
              // ignore: prefer_const_constructors
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                        child: TitleText(
                            lable:
                                "Title (${cardProvider.cardIteams.length} product/ ${cardProvider.getQuantit()} iteams) ")),
                    SubtitleText(
                      lable:
                          '${cardProvider.getToatalProd(productProvider: productProvider)}\$',
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                style: const ButtonStyle(
                  side: WidgetStatePropertyAll(
                    BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                ),
                onPressed: () async {
                  await function();
                },
                child: const Text(
                  'CheakOut',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
