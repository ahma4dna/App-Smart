import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoapsmart_useers_laerm/provider/card_provider.dart';
import 'package:shoapsmart_useers_laerm/provider/product_provider.dart';
import 'package:shoapsmart_useers_laerm/provider/viwed_recently.dart';
import 'package:shoapsmart_useers_laerm/screens/inner_secreen/product_deatels.dart';
import 'package:shoapsmart_useers_laerm/widgets/product/hart_bottun.dart';
import 'package:shoapsmart_useers_laerm/widgets/subtitle_text.dart';
import 'package:shoapsmart_useers_laerm/widgets/title_text.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({super.key, required this.productId});
  final String productId;

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    ///final productModeal = Provider.of<ProductModel>(context);
    final productProvider = ProductProvider.get(context);
    final getCurntProduct = productProvider.findByProId(widget.productId);
    final cardProvider = Provider.of<CardProvider>(context);
    Size size = MediaQuery.of(context).size;
    final viwedRecentlyProvider = Provider.of<ViwedRecentlyProvider>(context);
    return getCurntProduct == null
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.all(3.0),
            child: GestureDetector(
              onTap: () async {
                await Navigator.pushNamed(context, ProductDeatels.routeName,
                    arguments: getCurntProduct.productId);
                viwedRecentlyProvider.addToHistory(
                    productId: getCurntProduct.productId);
              },
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: FancyShimmerImage(
                      imageUrl: getCurntProduct.productImage,
                      width: size.height * 0.22,
                      height: size.height * 0.22,
                    ),
                  ),
                  // ignore: prefer_const_constructors
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 3,
                        child: TitleText(
                          lable: getCurntProduct.productTitle,
                          maxLine: 2,
                        ),
                      ),
                      Flexible(
                        child: HartBottunWidget(
                          productId: getCurntProduct.productId,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 2,
                        child: SubtitleText(
                          lable: "${getCurntProduct.productPrice} LYD",
                        ),
                      ),
                      Flexible(
                        child: Material(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(12),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () async{
                              if (cardProvider.isProductIncard(
                                  productId: getCurntProduct.productId)) {
                                return;
                              }
                              // cardProvider.addProductToCard(
                              //     productId: getCurntProduct.productId);
                            await  cardProvider.addCartToFirebase(
                                  productId: getCurntProduct.productId,
                                  quantiti: 1,
                                  context: context);
                            },
                            // ignore: prefer_const_constructors
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(cardProvider.isProductIncard(
                                      productId: getCurntProduct.productId)
                                  ? Icons.check
                                  : Icons.add_shopping_cart_outlined),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          );
  }
}
