import 'package:flutter/material.dart';
import 'package:shoapsmart_useers_laerm/conest/app_theam.dart';
import 'package:shoapsmart_useers_laerm/provider/card_provider.dart';
import 'package:shoapsmart_useers_laerm/provider/product_provider.dart';
import 'package:shoapsmart_useers_laerm/provider/theam_provider.dart';
import 'package:shoapsmart_useers_laerm/provider/viwed_recently.dart';
import 'package:shoapsmart_useers_laerm/provider/wishlist_provider.dart';
import 'package:shoapsmart_useers_laerm/root_screen.dart';
import 'package:provider/provider.dart';
import 'package:shoapsmart_useers_laerm/screens/forgt_password_secreen.dart';
import 'package:shoapsmart_useers_laerm/screens/inner_secreen/product_deatels.dart';
import 'package:shoapsmart_useers_laerm/screens/inner_secreen/viwed_recently.dart';
import 'package:shoapsmart_useers_laerm/screens/inner_secreen/wishlist_secreen.dart';
import 'package:shoapsmart_useers_laerm/screens/login_screen.dart';
import 'package:shoapsmart_useers_laerm/screens/order/order_screen.dart';
import 'package:shoapsmart_useers_laerm/screens/saerch_screen.dart';
import 'package:shoapsmart_useers_laerm/screens/sigin_up_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TheamProvider()..getTheam(),
        ),
          ChangeNotifierProvider(
          create: (context) =>ProductProvider(),
        ),
          ChangeNotifierProvider(
          create: (context) =>CardProvider(),
        ),
          ChangeNotifierProvider(
          create: (context) =>WishlistProvider(),
        ),
            ChangeNotifierProvider(
          create: (context) =>ViwedRecentlyProvider(),
        ),
      ],
      child: Consumer<TheamProvider>(
        builder: (context,TheamProvider,chaild) {
          return MaterialApp(
            home:   const RootScreen(),
            debugShowCheckedModeBanner: false,
            theme: Styles.themeData(isDarkTheam: TheamProvider.getIsDarkTheam, context: context),
            routes: {
              ProductDeatels.routeName:(context)=>const ProductDeatels(),
              WishlistSecreen.routeName:(context)=>const WishlistSecreen(),
              ViwedRecently.routeName:(context)=>const ViwedRecently(),
              SiginUpScreen.routName:(context)=>const SiginUpScreen(),
              OrderSecreen.roatName:(context)=>const OrderSecreen(),
              LoginScreen.roatName:(context)=>const LoginScreen(),
              ForgtPasswordSecreen.routName:(context)=>const ForgtPasswordSecreen(),
              SaerchScreen.routName:(context)=> SaerchScreen(),
            },
          );
        }
      ),
    );
  }
}
