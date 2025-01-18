// ignore_for_file: dead_code

import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoapsmart_useers_laerm/provider/viwed_recently.dart';
import 'package:shoapsmart_useers_laerm/services/image_manger.dart';
import 'package:shoapsmart_useers_laerm/services/mehtode_my_app.dart';
import 'package:shoapsmart_useers_laerm/widgets/empty_bag.dart';
import 'package:shoapsmart_useers_laerm/widgets/product/product_widget.dart';
import 'package:shoapsmart_useers_laerm/widgets/title_text.dart';

class ViwedRecently extends StatefulWidget {
    static const routeName = 'ViwedRecently';
  const ViwedRecently({super.key});

  @override
  State<ViwedRecently> createState() => _ViwedRecentlyState();
}

class _ViwedRecentlyState extends State<ViwedRecently> {
  @override
  Widget build(BuildContext context) {
        final viwedRecentlyProvider = Provider.of<ViwedRecentlyProvider>(context);
  
    return viwedRecentlyProvider.getViwedIea.isEmpty
        ? Scaffold(
            body: EmptyBag(
                title: 'Whoops!',
                subTitle: 'Your cart is empty',
                imagePthe: AssetsManager.recent,
                bodytext:
                    'Loocks Like you didint add anything yet to your cart \ngo and start shoping now',
                textBootun: 'Shop Now'),
          )
        : Scaffold(
        
            appBar: AppBar(
                    actions: [
                IconButton(
                  onPressed: () {
                    MehtodeMyApp.showErorrORwarnigDialog(
                        isErorr: false,
                        context: context,
                        subTile: "Clear All History",
                        fce: () {
                          viwedRecentlyProvider.clearAllIteamHistory();
                        });
                  },
                  icon: const Icon(
                    Icons.delete_forever,
                    color: Colors.red,
                  ),
                ),
              ],
              title:  TitleText(lable: 'Recently)(${viwedRecentlyProvider.getViwedIea.length})'),
              leading: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Image(
                  image: AssetImage(AssetsManager.shoppingCart),
                  fit: BoxFit.cover,
                ),
              ),
            
            ),
            body: DynamicHeightGridView(
                  builder: (context, index) =>  ProductWidget(
                     productId:viwedRecentlyProvider.getViwedIea.values.toList()[index].productId,
                  ),
                  itemCount: viwedRecentlyProvider.getViwedIea.length,
                  crossAxisCount: 2,
                ),
          );
  }
}