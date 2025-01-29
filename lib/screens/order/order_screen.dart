// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shoapsmart_useers_laerm/moeals/order_moel.dart';
import 'package:shoapsmart_useers_laerm/provider/orderProvider.dart';
import 'package:shoapsmart_useers_laerm/screens/order/order_widget.dart';
import 'package:shoapsmart_useers_laerm/services/image_manger.dart';
import 'package:shoapsmart_useers_laerm/widgets/empty_bag.dart';
import 'package:shoapsmart_useers_laerm/widgets/title_text.dart';

class OrderSecreen extends StatefulWidget {
  static String roatName = "OrderSecreen";
  const OrderSecreen({super.key});

  @override
  State<OrderSecreen> createState() => _OrderSecreenState();
}

class _OrderSecreenState extends State<OrderSecreen> {
  @override
  Widget build(BuildContext context) {
    final orderPro = Provider.of<Orderprovider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const TitleText(lable: 'Placed order'),
        leading: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Icon(
            IconlyBold.arrowLeft,
          ),
        ),
      ),
      body: FutureBuilder<List<OrdersModelAdvanced>>(
        future: orderPro.featchOrder(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return SelectableText("An erorr has ben ${snapshot.error}");
          } else if (!snapshot.hasData||orderPro.getOrder.isEmpty) {
            return EmptyBag(
                title: 'Whoops!',
                subTitle: 'Your order is empty',
                imagePthe: AssetsManager.shoppingBasket,
                bodytext:
                    'Loocks Like you didint add anything yet to your cart \ngo and start shoping now',
                textBootun: 'Shop Now');
          }
          return ListView.separated(
            itemBuilder: (context, index) =>  OrderWidget(
              order:orderPro.getOrder[index],
            ),
            itemCount: orderPro.getOrder.length,
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            },
          );
        },
      ),
    );
  }
}
