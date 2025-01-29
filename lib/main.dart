import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shoapsmart_useers_laerm/conest/app_theam.dart';
import 'package:shoapsmart_useers_laerm/provider/card_provider.dart';
import 'package:shoapsmart_useers_laerm/provider/orderProvider.dart';
import 'package:shoapsmart_useers_laerm/provider/product_provider.dart';
import 'package:shoapsmart_useers_laerm/provider/theam_provider.dart';
import 'package:shoapsmart_useers_laerm/provider/user_provider.dart';
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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
          future: Firebase.initializeApp(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
               return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (snapshot.hasError) {
              return Scaffold(
                body: SelectableText("An erorr has ben ${snapshot.error}"),
              );
            }
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (context) => TheamProvider()..getTheam(),
                ),
                ChangeNotifierProvider(
                  create: (context) => ProductProvider(),
                ),
                ChangeNotifierProvider(
                  create: (context) => CardProvider(),
                ),
                ChangeNotifierProvider(
                  create: (context) => WishlistProvider(),
                ),
                ChangeNotifierProvider(
                  create: (context) => ViwedRecentlyProvider(),
                ),
                  ChangeNotifierProvider(
                  create: (context) => UserProvider(),
                ),
                  ChangeNotifierProvider(
                  create: (context) =>Orderprovider(),
                ),
              ],
              child: Consumer<TheamProvider>(
                  builder: (context, themeProvider, chaild) {
                return MaterialApp(
                  home: const RootScreen(),
                  debugShowCheckedModeBanner: false,
                  theme: Styles.themeData(
                      isDarkTheam: themeProvider.getIsDarkTheam,
                      context: context),
                  routes: {
                    ProductDeatels.routeName: (context) => const ProductDeatels(),
                    WishlistSecreen.routeName: (context) =>
                        const WishlistSecreen(),
                    ViwedRecently.routeName: (context) => const ViwedRecently(),
                    SiginUpScreen.routName: (context) => const SiginUpScreen(),
                    OrderSecreen.roatName: (context) => const OrderSecreen(),
                    LoginScreen.roatName: (context) => const LoginScreen(),
                    ForgtPasswordSecreen.routName: (context) =>
                        const ForgtPasswordSecreen(),
                    SaerchScreen.routName: (context) => SaerchScreen(),
                    // ignore: prefer_const_constructors
                    RootScreen.routName:(context)=>RootScreen(),
                  },
                );
              }),
            );
          }),
    );
  }
}
