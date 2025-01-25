import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shoapsmart_useers_laerm/conest/myValiditor.dart';
import 'package:shoapsmart_useers_laerm/root_screen.dart';
import 'package:shoapsmart_useers_laerm/screens/loading_manger.dart';
import 'package:shoapsmart_useers_laerm/services/mehtode_my_app.dart';
import 'package:shoapsmart_useers_laerm/widgets/auth/dialog_sigin_up.dart';
import 'package:shoapsmart_useers_laerm/widgets/auth/pickeImage_widget.dart';
import 'package:shoapsmart_useers_laerm/widgets/name_app_text.dart';
import 'package:shoapsmart_useers_laerm/widgets/subtitle_text.dart';
import 'package:shoapsmart_useers_laerm/widgets/title_text.dart';

class SiginUpScreen extends StatefulWidget {
  const SiginUpScreen({super.key});
  static String routName = 'SiginUpScreen';

  @override
  State<SiginUpScreen> createState() => _SiginUpScreenState();
}

class _SiginUpScreenState extends State<SiginUpScreen> {
  var nameControler = TextEditingController();
  var emailControler = TextEditingController();
  var passwordControler = TextEditingController();
  var requestPasswordControler = TextEditingController();
  var key = GlobalKey<FormState>();
  bool obscure = true;
  bool obscureRequest = true;
  XFile? pickedImage;
  bool isLoading = false;
  String? urlImage;
  final auth = FirebaseAuth.instance;

  Future<void> localImageOicker() async {
    final ImagePicker picker = ImagePicker();
    MehtodeMyApp.imagePickerDialog(
      context: context,
      cameraFCT: () async {
        pickedImage = await picker.pickImage(source: ImageSource.camera);
        setState(() {});
      },
      galleryFCT: () async {
        pickedImage = await picker.pickImage(source: ImageSource.gallery);
        setState(() {});
      },
      removeFCT: () {
        setState(() {
          pickedImage = null;
        });
      },
    );
  }

  Future<void> signUp() async {
    bool isValid = key.currentState!.validate();
    FocusScope.of(context).unfocus();
      ///pricing image to firebase storage
    // if (pickedImage == null) {
    //     MehtodeMyApp.showErorrORwarnigDialog(
    //       context: context,
    //       subTile: "Make sure to pick up an image",
    //       fce: () {},
    //     );
    //   }
    if (isValid) {
      key.currentState!.save();

      try {
        setState(() {
          isLoading = true;
        });
        
        ///pricing image to firebase storage
        // final ref = FirebaseStorage.instance
        //     .ref()
        //     .child("userImage")
        //     .child("${emailControler.text.trim()}.jpj");
        // ref.putFile(File(pickedImage!.path));
        // urlImage = await ref.getDownloadURL();
        await auth.createUserWithEmailAndPassword(
          email: emailControler.text.trim(),
          password: passwordControler.text.trim(),
        );

        await FirebaseFirestore.instance
            .collection("users")
            .doc(auth.currentUser!.uid)
            .set(
          {
            "userId": auth.currentUser!.uid,
            "userName": nameControler.text,
            "userEmail": emailControler.text,
            "userImage": urlImage ??
                "https://firebasestorage.googleapis.com/v0/b/udemy-89ded.appspot.com/o/users%2F1000012507.jpg?alt=media&token=c73e60d4-e7f2-4202-948e-37ed73be2596",
            "createdAt": Timestamp.now(),
            "userCart": [],
            "userWishlist": [],
          },
        );
        Fluttertoast.showToast(
          msg: "An acount has ben creat",
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.white,
        );
        if (!mounted) return;
        await Navigator.pushReplacementNamed(context, RootScreen.routName);
      } on FirebaseException catch (eror) {
        await MehtodeMyApp.showErorrORwarnigDialog(
          context: context,
          subTile: "Erorr Sign up ${eror.message}",
          fce: () {},
        );
      } catch (eror) {
        await MehtodeMyApp.showErorrORwarnigDialog(
          context: context,
          subTile: "Erorr Sign up $eror",
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // ignore: prefer_const_constructors
      body: LoadingManger(
        isloading: isLoading,
        chaild: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 35,
                  ),
                  const Center(
                    child: NameAppText(
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  const TitleText(
                    lable: "Welcome",
                    fontSize: 25,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SubtitleText(
                    lable:
                        "sign up now to recive spicel offres and update frome our app",
                    fontSize: 15,
                  ),
                  Center(
                    child: SizedBox(
                      width: size.width * 0.35,
                      height: size.width * 0.35,
                      child: PickeimageWidget(
                        pickedImage: pickedImage,
                        function: () {
                          localImageOicker();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Pleass Add Name";
                      } else {
                        return null;
                      }
                    },
                    controller: nameControler,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Add Name",
                      prefixIcon: Icon(IconlyLight.user2),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
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
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Add Email ",
                      prefixIcon: Icon(IconlyLight.message),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Pleass Add password";
                      } else {
                        return null;
                      }
                    },
                    obscureText: obscure,
                    controller: passwordControler,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: "Add Password",
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
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      return Myvaliditor.RequstPassowrd(
                          value: value, passsword: passwordControler.text);
                    },
                    controller: requestPasswordControler,
                    obscureText: obscureRequest,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: "Add Request Password ",
                      prefixIcon: const Icon(IconlyLight.password),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscureRequest = !obscureRequest;
                          });
                        },
                        icon: obscureRequest
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (key.currentState!.validate()) {
                        signUp();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey[100],
                      elevation: 4,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      minimumSize: const Size(double.infinity, 55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Sigin up',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
