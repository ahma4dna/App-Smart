import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shoapsmart_useers_laerm/provider/theam_provider.dart';
import 'package:shoapsmart_useers_laerm/screens/inner_secreen/viwed_recently.dart';
import 'package:shoapsmart_useers_laerm/screens/inner_secreen/wishlist_secreen.dart';
import 'package:shoapsmart_useers_laerm/screens/login_screen.dart';
import 'package:shoapsmart_useers_laerm/screens/order/order_screen.dart';
import 'package:shoapsmart_useers_laerm/services/image_manger.dart';
import 'package:shoapsmart_useers_laerm/services/mehtode_my_app.dart';
import 'package:shoapsmart_useers_laerm/widgets/custom_list_tile.dart';
import 'package:shoapsmart_useers_laerm/widgets/name_app_text.dart';
import 'package:shoapsmart_useers_laerm/widgets/subtitle_text.dart';
import 'package:shoapsmart_useers_laerm/widgets/title_text.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final themeProvider = TheamProvider.get(context);
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
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Visibility(
              visible: false,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: TitleText(lable: 'Pleasse to havev unlatimte acces'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).cardColor,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.surface,
                        width: 3,
                      ),
                      image: const DecorationImage(
                        image: NetworkImage(
                            'https://img.freepik.com/premium-vector/user-circle-with-blue-gradient-circle_78370-4727.jpg?ga=GA1.1.398565215.1725138437&semt=ais_hybrid'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleText(lable: 'Ahmad Nagy'),
                      SubtitleText(lable: 'ahmadna@gmail.com'),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 24,
                horizontal: 12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TitleText(lable: 'General'),
                  CustomListTile(
                    text: 'All order',
                    imagePthe: AssetsManager.orderSvg,
                    icon: IconlyBold.arrowRight2,
                    function: () {
                      Navigator.pushNamed(context, OrderSecreen.roatName);
                    },
                  ),
                  CustomListTile(
                    text: 'Wishlist',
                    imagePthe: AssetsManager.wishlistSvg,
                    icon: IconlyBold.arrowRight2,
                    function: () async {
                      await Navigator.pushNamed(
                          context, WishlistSecreen.routeName);
                    },
                  ),
                  CustomListTile(
                    text: 'Viwede recenly',
                    imagePthe: AssetsManager.recent,
                    icon: IconlyBold.arrowRight2,
                    function: () async {
                      await Navigator.pushNamed(
                          context, ViwedRecently.routeName);
                    },
                  ),
                  CustomListTile(
                    text: 'Addres',
                    imagePthe: AssetsManager.address,
                    icon: IconlyBold.arrowRight2,
                    function: () {},
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 10,
                  ),
                  const TitleText(lable: 'Setings'),
                  SwitchListTile(
                    activeColor: Colors.blue,
                    secondary: Image.asset(
                      AssetsManager.theme,
                      height: 30,
                    ),
                    title: Text(themeProvider.getIsDarkTheam
                        ? 'Dark Mode'
                        : 'Light Mode'),
                    value: themeProvider.getIsDarkTheam,
                    onChanged: (value) {
                      themeProvider.setTheam(theamValue: value);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Center(
                      child: ElevatedButton.icon(
                        style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Colors.blue),
                        ),
                        icon: Icon(
                          user == null ? Icons.login : Icons.logout,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          if (user == null) {
                            Navigator.pushNamed(context, LoginScreen.roatName);
                          } else {
                            MehtodeMyApp.showErorrORwarnigDialog(
                              context: context,
                              subTile: "Hello test",
                              fce: () async {
                                await FirebaseAuth.instance.signOut();
                                if (!mounted) return;
                                await Navigator.pushNamed(
                                    context, LoginScreen.roatName);
                              },
                              isErorr: false,
                            );
                          }
                        },
                        label: Text(
                          user == null ? "SignIn" : 'LogOut',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
