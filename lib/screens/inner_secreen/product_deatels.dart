import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shoapsmart_useers_laerm/provider/card_provider.dart';
import 'package:shoapsmart_useers_laerm/provider/product_provider.dart';
import 'package:shoapsmart_useers_laerm/widgets/name_app_text.dart';
import 'package:shoapsmart_useers_laerm/widgets/product/hart_bottun.dart';
import 'package:shoapsmart_useers_laerm/widgets/subtitle_text.dart';
import 'package:shoapsmart_useers_laerm/widgets/title_text.dart';

class ProductDeatels extends StatefulWidget {
  static const routeName = 'ProductDeatels';
  const ProductDeatels({super.key});

  @override
  State<ProductDeatels> createState() => _ProductDeatelsState();
}

class _ProductDeatelsState extends State<ProductDeatels> {
  @override
  Widget build(BuildContext context) {
    
    final cardProvider = Provider.of<CardProvider>(context);
    Size size = MediaQuery.of(context).size;
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final getCurntProduct = productProvider.findByProId(productId);
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_ios),
        title: const Center(
          child: NameAppText(
            fontSize: 20,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Badge(
              label: const TitleText(
                lable: '3',
                fontSize: 10,
              ),
              backgroundColor: Colors.red,
              isLabelVisible: true,
              child: Container(
                height: 70,
                width: 55,
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: IconButton(
                  color: Colors.black,
                  onPressed: () {},
                  icon: const Icon(IconlyLight.bag),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: getCurntProduct == null
            ? const SizedBox.shrink()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image(
                      fit: BoxFit.cover,
                      height: size.height * 0.40,
                      width: double.infinity,
                      image: NetworkImage(getCurntProduct.productImage),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // ignore: prefer_const_constructors
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: SubtitleText(
                            lable: '${getCurntProduct.productTitle} ',
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SubtitleText(
                          lable: '${getCurntProduct.productPrice} \$',
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(40)),
                        ),
                        child:  HartBottunWidget(
                          productId: getCurntProduct.productId,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      OutlinedButton.icon(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                            Colors.blue[50],
                          ),
                          padding: WidgetStateProperty.all(
                            const EdgeInsetsDirectional.symmetric(
                              vertical: 15,
                              horizontal: 90,
                            ),
                          ),
                          side: WidgetStateProperty.all(
                            BorderSide.none,
                          ),
                        ),
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
                        label:  Text(cardProvider.isProductIncard(
                                      productId: getCurntProduct.productId)?
                        'Product in card':  'Add to cart',
                        style: TextStyle(color: Colors.black),
                        ),
                        icon:  Icon(cardProvider.isProductIncard(
                                      productId: getCurntProduct.productId)
                                  ? Icons.check
                                  : Icons.add_shopping_cart_outlined,color: Colors.black,),
                                  
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const TitleText(
                          lable: 'About This Iteam',
                          fontSize: 20,
                        ),
                        Text(
                          'in ${getCurntProduct.productCategory}',
                          style: const TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text('${getCurntProduct.productDescription}'),
                  ),
                ],
              ),
      ),
    );
  }
}
