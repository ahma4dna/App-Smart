import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shoapsmart_useers_laerm/services/image_manger.dart';
import 'package:shoapsmart_useers_laerm/widgets/name_app_text.dart';
import 'package:shoapsmart_useers_laerm/widgets/subtitle_text.dart';
import 'package:shoapsmart_useers_laerm/widgets/title_text.dart';

class ForgtPasswordSecreen extends StatelessWidget {
  static String routName = "ForgtPasswordSecreen";

  const ForgtPasswordSecreen({super.key});

  @override
  Widget build(BuildContext context) {
    var emailControler = TextEditingController();
    var key = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        // ignore: prefer_const_constructors
        title: NameAppText(
          fontSize: 27,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: key,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(AssetsManager.forgotPassword,height: 250,width: double.infinity,fit: BoxFit.cover,),
                const SizedBox(
                  height: 20,
                ),
                const TitleText(
                  lable: "Forget Password",
                  fontSize: 25,
                ),
                const SizedBox(
                  height: 10,
                ),
                const SubtitleText(
                  lable:
                      "please enter the email adders you like your password resent informetion sent to",
                  fontSize: 15,
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
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.blueGrey[100],
                    border: const OutlineInputBorder(),
                    hintText: "Add Email ",
                    prefixIcon: const Icon(IconlyLight.message),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    if (key.currentState!.validate()) {}
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    elevation: 4,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  label: const Text(
                    'Request Link',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  icon: const Icon(
                    IconlyBold.send,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
