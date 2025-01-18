import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  const TitleText({
    super.key,
    required this.lable,
    this.maxLine = 1,
    this.fontSize = 20,
    this.color, this.textOverflow,
  });
  final String lable;
  final int? maxLine;
  final double? fontSize;
  final Color? color;
  final TextOverflow? textOverflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      lable,
      maxLines: maxLine,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: FontWeight.bold,
        overflow: textOverflow,
      ),
    );
  }
}
