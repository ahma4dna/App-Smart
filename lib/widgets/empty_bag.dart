import 'package:flutter/material.dart';
import 'package:shoapsmart_useers_laerm/widgets/subtitle_text.dart';
import 'package:shoapsmart_useers_laerm/widgets/title_text.dart';

class EmptyBag extends StatelessWidget {
  const EmptyBag(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.imagePthe,
      required this.bodytext,
      required this.textBootun,
      this.colorTitle=Colors.red});
  final String title;
  final String subTitle;
  final String imagePthe;
  final String bodytext;
  final String textBootun;
  final Color? colorTitle;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Image.asset(
              imagePthe,
              height: size.height * 0.35,
              width: double.infinity,
            ),
            const SizedBox(
              height: 10,
            ),
            TitleText(
              lable: title,
              color: colorTitle,
              fontSize: 40,
            ),
            const SizedBox(
              height: 15,
            ),
            SubtitleText(
              lable: subTitle,
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SubtitleText(
                lable: bodytext,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: const ButtonStyle(
                padding: WidgetStatePropertyAll(
                  EdgeInsets.all(20),
                ),
              ),
              onPressed: () {},
              child: Text(
                textBootun,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
