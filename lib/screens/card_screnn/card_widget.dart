import 'package:flutter/material.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shoapsmart_useers_laerm/conest/app_conestant.dart';
import 'package:shoapsmart_useers_laerm/moeals/card_models.dart';
import 'package:shoapsmart_useers_laerm/provider/card_provider.dart';
import 'package:shoapsmart_useers_laerm/provider/product_provider.dart';
import 'package:shoapsmart_useers_laerm/screens/card_screnn/quantiti_bottoun_sheat.dart';
import 'package:shoapsmart_useers_laerm/screens/inner_secreen/product_deatels.dart';
import 'package:shoapsmart_useers_laerm/widgets/product/hart_bottun.dart';
import 'package:shoapsmart_useers_laerm/widgets/subtitle_text.dart';
import 'package:shoapsmart_useers_laerm/widgets/title_text.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cardMoelProvier = Provider.of<CardModels>(context);
    final productProvider = ProductProvider.get(context);
    final getCurntProduct =
        productProvider.findByProId(cardMoelProvier.productId);
    Size size = MediaQuery.of(context).size;
    final cardProvider = Provider.of<CardProvider>(context);
    return GestureDetector(
      onTap: () async {
        await Navigator.pushNamed(context, ProductDeatels.routeName,
            arguments: getCurntProduct!.productId);
      },
      child: getCurntProduct == null
          ? SizedBox.shrink()
          : FittedBox(
              child: IntrinsicWidth(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: FancyShimmerImage(
                          imageUrl: getCurntProduct.productImage,
                          height: size.height * 0.2,
                          width: size.height * 0.2,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    IntrinsicWidth(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: size.width * 0.6,
                                child: TitleText(
                                  lable: getCurntProduct.productTitle,
                                  maxLine: 2,
                                ),
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      // cardProvider.removeOneIeam(
                                      //     productId: cardMoelProvier.productId);
                                      await cardProvider
                                          .clearOneteamCardFirbase(
                                        productId: getCurntProduct.productId,
                                        quantiti: cardMoelProvier.quantiti,
                                        cardId: cardMoelProvier.cardId,
                                      );
                                    },
                                    icon: Icon(
                                      IconlyBold.delete,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  HartBottunWidget(
                                    productId: getCurntProduct.productId,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SubtitleText(
                                lable: '${getCurntProduct.productPrice}\$',
                                color: Colors.blue,
                              ),
                              OutlinedButton.icon(
                                style: ButtonStyle(
                                    shape: WidgetStatePropertyAll(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    side: const WidgetStatePropertyAll(
                                      BorderSide(
                                        color: Colors.blue,
                                      ),
                                    )),
                                onPressed: () async {
                                  await showModalBottomSheet(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30),
                                        bottomLeft: Radius.zero,
                                        bottomRight: Radius.zero,
                                      ),
                                    ),
                                    context: context,
                                    builder: (context) => QuantitiBottounSheat(
                                      cardModels: cardMoelProvier,
                                    ),
                                  );
                                },
                                label: Text(
                                  'Quntity : ${cardMoelProvier.quantiti}',
                                  style: TextStyle(color: Colors.blue),
                                ),
                                icon: const Icon(
                                  IconlyLight.arrowDown2,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
