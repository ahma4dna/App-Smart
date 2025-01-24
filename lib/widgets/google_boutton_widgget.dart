import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shoapsmart_useers_laerm/root_screen.dart';
import 'package:shoapsmart_useers_laerm/services/mehtode_my_app.dart';

class GoogleBouttonWidgget extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  GoogleBouttonWidgget({
    super.key,
  });

  Future<void> signInWithGoogle({required BuildContext context}) async {
    final googleSignIn = GoogleSignIn();
    final googleAcount = await googleSignIn.signIn();
    if (googleAcount != null) {
      final googleAuth = await googleAcount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        try {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            final authResult = FirebaseAuth.instance.signInWithCredential(
              GoogleAuthProvider.credential(
                accessToken: googleAuth.accessToken,
                idToken: googleAuth.idToken,
              ),
            );
          });
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
