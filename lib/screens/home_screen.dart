import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoapsmart_useers_laerm/conest/app_conestant.dart';
import 'package:shoapsmart_useers_laerm/provider/product_provider.dart';
import 'package:shoapsmart_useers_laerm/services/image_manger.dart';
import 'package:shoapsmart_useers_laerm/widgets/name_app_text.dart';
import 'package:shoapsmart_useers_laerm/widgets/product/catogres_rounded_product.dart';
import 'package:shoapsmart_useers_laerm/widgets/product/latest_areival.dart';
import 'package:shoapsmart_useers_laerm/widgets/title_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductProvider productProvider =
        Provider.of<ProductProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const NameAppText(
          fontSize: 25,
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Image(
            image: AssetImage(AssetsManager.shoppingCart),
            fit: BoxFit.cover,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 12,
            right: 12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.24,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: Swiper(
                    autoplay: true,
                    itemBuilder: (context, index) =>
                        Image.asset(AppConestant.imageBaners[index]),
                    itemCount: AppConestant.imageBaners.length,
                    pagination: const SwiperPagination(
                      builder: DotSwiperPaginationBuilder(
                        activeColor: Colors.blue,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 8,
                ),
                child: Visibility(
                  visible: productProvider.getProduct.isNotEmpty,
                  child: const TitleText(
                    lable: "Ltast Arival",
                  ),
                ),
              ),
              Visibility(
                visible: productProvider.getProduct.isNotEmpty,
                child: SizedBox(
                  height: size.height * 0.2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: productProvider.getProduct.length < 10
                          ? productProvider.getProduct.length
                          : 10,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          ChangeNotifierProvider.value(
                              value: productProvider.getProduct[index],
                              child: LatestAreivalProduct(
                                productId:
                                    productProvider.getProduct[index].productId,
                              )),
                    ),
                  ),
                ),
              ),

              // ignore: prefer_const_constructors
              TitleText(
                lable: "Catogries",
              ),
              const SizedBox(
                height: 15,
              ),
              GridView.count(
                shrinkWrap: true,
                // ignore: prefer_const_constructors
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 4,

                children: List.generate(
                  AppConestant.catogriesModels.length,
                  (index) => CatogresRoundedProduct(
                    name: AppConestant.catogriesModels[index].name,
                    image: AppConestant.catogriesModels[index].image,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
