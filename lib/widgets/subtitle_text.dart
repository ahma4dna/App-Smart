import 'package:flutter/material.dart';

class SubtitleText extends StatelessWidget {
  const SubtitleText(
      {super.key,
      required this.lable,
      this.color,
      this.fontSize=20,
      this.fontWeight=FontWeight.normal,
      this.fontStyle=FontStyle.normal,
      this.decorationText=TextDecoration.none});
  final String lable;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final TextDecoration? decorationText;
  @override
  Widget build(BuildContext context) {
    return Text(
      lable,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        decoration: decorationText,
      ),
    );
  }
}
