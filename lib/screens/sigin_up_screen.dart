import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shoapsmart_useers_laerm/conest/myValiditor.dart';
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

  Future<void> localImageOicker() async {
    final ImagePicker picker = ImagePicker();
    DialogSiginUp.showAddImageNewUserDialog(
      context: context,
      cameraFun: () async {
        pickedImage = await picker.pickImage(source: ImageSource.camera);
        setState(() {
          
        });
      },
      gallaryFun: () async {
        pickedImage = await picker.pickImage(source: ImageSource.gallery);
        setState(() {
          
        });
      },
      removeFun: () {
        
          
        
        setState(() {
          pickedImage = null;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // ignore: prefer_const_constructors
      body: Padding(
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
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.blueGrey[100],
                    border: const OutlineInputBorder(),
                    hintText: "Add Name",
                    prefixIcon: const Icon(IconlyLight.user2),
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
                    filled: true,
                    fillColor: Colors.blueGrey[100],
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
                    filled: true,
                    fillColor: Colors.blueGrey[100],
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
                    if (key.currentState!.validate()) {}
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
    );
  }
}
