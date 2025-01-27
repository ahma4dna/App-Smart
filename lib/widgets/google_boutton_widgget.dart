import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shoapsmart_useers_laerm/provider/card_provider.dart';
import 'package:shoapsmart_useers_laerm/provider/wishlist_provider.dart';
import 'package:shoapsmart_useers_laerm/root_screen.dart';
import 'package:shoapsmart_useers_laerm/services/mehtode_my_app.dart';

class GoogleBouttonWidgget extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  GoogleBouttonWidgget({
    super.key,
  });

  Future<void> signInWithGoogle({required BuildContext context}) async {
    final wishlistProvider =
        Provider.of<WishlistProvider>(context, listen: false);
    final cardPro = Provider.of<CardProvider>(context, listen: false);
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    final googleAcount = await googleSignIn.signIn();
    if (googleAcount != null) {
      final googleAuth = await googleAcount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        try {
          /// is awiting for the  result of the authReslt

          final authResult = await FirebaseAuth.instance.signInWithCredential(
            GoogleAuthProvider.credential(
              accessToken: googleAuth.accessToken,
              idToken: googleAuth.idToken,
            ),
          );

          if (authResult.additionalUserInfo!.isNewUser) {
            log("New User With google");
            await FirebaseFirestore.instance
                .collection("users")
                .doc(authResult.user!.uid)
                .set(
              {
                "userId": authResult.user!.uid,
                "userName": authResult.user!.displayName,
                "userEmail": authResult.user!.email,
                "userImage": authResult.user!.photoURL,
                "createdAt": Timestamp.now(),
                "userCart": [],
                "userWishlist": [],
              },
            );
          }
          cardPro.clearAllIteam();
          wishlistProvider.clearAllIteamWishList();

          WidgetsBinding.instance.addPostFrameCallback((_) async {
            await Navigator.pushReplacementNamed(context, RootScreen.routName);
          });
        } on FirebaseException catch (eror) {
          await MehtodeMyApp.showErorrORwarnigDialog(
            context: context,
            subTile: "Erorr Sign in with google ${eror.message}",
            fce: () {},
          );
        } catch (eror) {
          await MehtodeMyApp.showErorrORwarnigDialog(
            context: context,
            subTile: "Erorr Sign with google $eror",
            fce: () {},
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueGrey[100],
        elevation: 2,
        minimumSize: const Size(50, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      icon: const Icon(
        Icons.g_mobiledata,
        size: 30,
        color: Colors.red,
      ),
      onPressed: () async {
        await signInWithGoogle(context: context);
      },
      label: const Text(
        'Log in with google',
        style: TextStyle(
          color: Colors.black,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
