import 'package:flutter/material.dart';
import 'package:shoapsmart_useers_laerm/widgets/subtitle_text.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile(
      {super.key,
      required this.text,
      required this.imagePthe,
      this.higt = 30,
      required this.icon,
      required this.function});
  final String text, imagePthe;
  final double? higt;
  final IconData icon;
  final Function function;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        function();
      },
      leading: Image.asset(
        imagePthe,
        height: higt,
      ),
      title: SubtitleText(lable: text),
      trailing: Icon(
        icon,
      ),
    );
  }
}
