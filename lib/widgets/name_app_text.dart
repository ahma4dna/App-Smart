import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shoapsmart_useers_laerm/widgets/title_text.dart';

class NameAppText extends StatelessWidget {
  const NameAppText({super.key, this.fontSize = 30});
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      direction: ShimmerDirection.ltr,
      period: const Duration(
        seconds: 5,
      ),
      baseColor: Colors.purple,
      highlightColor: Colors.blue,
      child: TitleText(
        lable: 'Shop Smart',
        fontSize: fontSize,
      ),
    );
  }
}
