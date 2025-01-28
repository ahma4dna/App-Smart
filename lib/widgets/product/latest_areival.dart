
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoapsmart_useers_laerm/moeals/product_mosel.dart';
import 'package:shoapsmart_useers_laerm/provider/card_provider.dart';
import 'package:shoapsmart_useers_laerm/provider/product_provider.dart';
import 'package:shoapsmart_useers_laerm/provider/viwed_recently.dart';
import 'package:shoapsmart_useers_laerm/screens/inner_secreen/product_deatels.dart';
import 'package:shoapsmart_useers_laerm/widgets/product/hart_bottun.dart';
import 'package:shoapsmart_useers_laerm/widgets/subtitle_text.dart';
import 'package:shoapsmart_useers_laerm/widgets/title_text.dart';

class LatestAreivalProduct extends StatelessWidget {
  const LatestAreivalProduct({super.key, required this.productId});
  final String productId;
  @override
  Widget build(BuildContext context) {
    final ProductModel getProduct = Provider.of<ProductModel>(context);
    final ProductProvider productProvider =
        Provider.of<ProductProvider>(context);
        
    
    final cardProvider = Provider.of<CardProvider>(context);
    final getCurntProduct = productProvider.findByProId(productId);
    final viwedRecentlyProvider = Provider.of<ViwedRecentlyProvider>(context);
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () async {
        await Navigator.pushNamed(context, ProductDeatels.routeName,
            arguments: getCurntProduct.productId);
        viwedRecentlyProvider.addToHistory(
            productId: getCurntProduct.productId);
      },
      child: SizedBox(
        width: size.width * 0.45,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: FancyShimmerImage(
                  imageUrl: getProduct.productImage,
                  height: size.width * 0.25,
                  width: size.width * 0.30,
                ),
              ),
            ),
            // ignore: prefer_const_constructors
            SizedBox(
              width: 10,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ignore: prefer_const_constructors
                  TitleText(
                    lable: getProduct.productTitle,
                    maxLine: 2,
                    fontSize: 15,
                  ),

                  FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () async{
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
                          icon:  Icon(cardProvider.isProductIncard(
                                      productId: getCurntProduct!.productId)
                                  ? Icons.check
                                  : 
                            Icons.add_shopping_cart_outlined,
                            size: 25,
                          ),
                        ),
                        HartBottunWidget(
                          productId: getProduct.productId,
                        ),
                      ],
                    ),
                  ),
                  // ignore: prefer_const_constructors
                  FittedBox(
                    child: SubtitleText(
                      lable: "${getProduct.productPrice} LYD",
                      color: Colors.blue,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),

            // ignore: prefer_const_constructors
            SizedBox(
              width: 15,
            ),
          ],
        ),
      ),
    );
  }
}
