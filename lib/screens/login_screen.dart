import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shoapsmart_useers_laerm/root_screen.dart';
import 'package:shoapsmart_useers_laerm/screens/forgt_password_secreen.dart';
import 'package:shoapsmart_useers_laerm/screens/loading_manger.dart';
import 'package:shoapsmart_useers_laerm/screens/sigin_up_screen.dart';
import 'package:shoapsmart_useers_laerm/services/mehtode_my_app.dart';
import 'package:shoapsmart_useers_laerm/widgets/google_boutton_widgget.dart';
import 'package:shoapsmart_useers_laerm/widgets/name_app_text.dart';
import 'package:shoapsmart_useers_laerm/widgets/subtitle_text.dart';
import 'package:shoapsmart_useers_laerm/widgets/title_text.dart';

class LoginScreen extends StatefulWidget {
  static String roatName = "LoginScreen";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailControler = TextEditingController();
  var passwordControler = TextEditingController();
  var key = GlobalKey<FormState>();
  bool obscure = true;
  bool isLoading = false;
  final auth = FirebaseAuth.instance;

  Future<void> logIn() async {
    bool isValid = key.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      key.currentState!.save();

      try {
        setState(() {
          isLoading = true;
        });
        await auth.signInWithEmailAndPassword(
          email: emailControler.text.trim(),
          password: passwordControler.text.trim(),
        );
        Fluttertoast.showToast(
          msg: "log in sucecss",
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.white,
        );
        if (!mounted) return;
        await Navigator.pushReplacementNamed(context, RootScreen.routName);
      } on FirebaseException catch (eror) {
        await MehtodeMyApp.showErorrORwarnigDialog(
          // ignore: use_build_context_synchronously
          context: context,
          subTile: "Erorr Log in ${eror.message}",
          fce: () {},
        );
      } catch (eror) {
        await MehtodeMyApp.showErorrORwarnigDialog(
          // ignore: use_build_context_synchronously
          context: context,
          subTile: "Erorr Log in $eror",
          fce: () {},
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: prefer_const_constructors
      body: LoadingManger(
        isloading: isLoading,
        chaild: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: key,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  const Center(
                      child: NameAppText(
                    fontSize: 35,
                  )),
                  const SizedBox(
                    height: 35,
                  ),
                  const TitleText(
                    lable: "Welcomw Back",
                    fontSize: 26,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SubtitleText(
                    lable: "Letes get loged in sey you can start exploring",
                    fontSize: 15,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Pleass Add Email";
                      } else {
                        return null;
                      }
                    },
                    controller: emailControler,
                    // ignore: prefer_const_constructors
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: "Add Email Addres",
                      prefixIcon: const Icon(IconlyLight.message),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Pleass Add Passwrd";
                      } else {
                        return null;
                      }
                    },
                    controller: passwordControler,
                    obscureText: obscure,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: "Add Password ",
                      prefixIcon: const Icon(IconlyLight.password),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscure = !obscure;
                          });
                        },
                        icon: obscure
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, ForgtPasswordSecreen.routName);
                        },
                        child: const Text(
                          "ForgtPasswrd?",
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (key.currentState!.validate()) {
                        logIn();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey[100],
                      elevation: 6,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Log in',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Center(
                    child: Text(
                      'OR CONEACT USEING',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      GoogleBouttonWidgget(
                      
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueGrey[100],
                          elevation: 2,
                          minimumSize: const Size(50, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {Navigator.pushReplacementNamed(context, RootScreen.routName);},
                        child: const Text(
                          'GUAEST',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  const TitleText(lable: "Dont have Account?"),
                      const SizedBox(
                        width: 5,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, SiginUpScreen.routName);
                        },
                        child: const TitleText(
                          lable: "Sign Up",
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
