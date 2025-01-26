import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shoapsmart_useers_laerm/moeals/product_mosel.dart';
import 'package:shoapsmart_useers_laerm/provider/product_provider.dart';
import 'package:shoapsmart_useers_laerm/services/image_manger.dart';
import 'package:shoapsmart_useers_laerm/widgets/product/product_widget.dart';
import 'package:shoapsmart_useers_laerm/widgets/title_text.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';

class SaerchScreen extends StatefulWidget {
  static String routName = "SaerchScreen";
  // ignore: prefer_const_constructors_in_immutables
  SaerchScreen({super.key});

  @override
  State<SaerchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SaerchScreen> {
  late TextEditingController searchTextControllar;
  @override
  void initState() {
    searchTextControllar = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchTextControllar.dispose();
    super.dispose();
  }

  List<ProductModel> productListSerch = [];

  @override
  Widget build(BuildContext context) {
    final productProvider = ProductProvider.get(context);
    String? passedNameCatogry =
        ModalRoute.of(context)!.settings.arguments as String?;
    List<ProductModel> productList = passedNameCatogry == null
        ? productProvider.getProduct
        : productProvider.findByCato(passedNameCatogry);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: TitleText(lable: passedNameCatogry ?? 'Search'),
          leading: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Image(
              image: AssetImage(AssetsManager.shoppingCart),
              fit: BoxFit.cover,
            ),
          ),
        ),
        body: productList.isEmpty
            ? const Center(child: TitleText(lable: "Catogry Empty"))
            : StreamBuilder<List<ProductModel>>(
                stream: productProvider.featchProductsStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: TitleText(
                        lable: snapshot.error.toString(),
                      ),
                    );
                  } else if (snapshot.data == null) {
                    return Center(
                      child: TitleText(
                        lable: snapshot.error.toString(),
                      ),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: searchTextControllar,
                          decoration: InputDecoration(
                            hintText: "Search",
                            // ignore: prefer_const_constructors
                            prefixIcon: Icon(IconlyLight.search),
                            suffixIcon: IconButton(
                              onPressed: () {
                                // setState(() {
                                searchTextControllar.clear();
                                FocusScope.of(context).unfocus();
                                // });
                              },
                              icon: const Icon(Icons.close),
                            ),
                          ),
                          onChanged: (value) {
                            // setState(() {
                            //   productListSerch = productProvider
                            //       .serchQuery(searchTextControllar.text);
                            // });
                          },
                          onSubmitted: (value) {
                            setState(() {
                              productListSerch = productProvider.serchQuery(
                                  searchTextControllar.text, productList);
                            });
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        if (productListSerch.isEmpty &&
                            searchTextControllar.text.isNotEmpty) ...[
                          const Center(
                            child: TitleText(
                              lable: "Not found product",
                              fontSize: 35,
                            ),
                          ),
                        ],
                        Expanded(
                          child: DynamicHeightGridView(
                            builder: (context, index) => ProductWidget(
                              productId: searchTextControllar.text.isNotEmpty
                                  ? productListSerch[index].productId
                                  : productList[index].productId,
                            ),
                            itemCount: searchTextControllar.text.isNotEmpty
                                ? productListSerch.length
                                : productList.length,
                            crossAxisCount: 2,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
      ),
    );
  }
}
