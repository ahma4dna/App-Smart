// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shoapsmart_useers_laerm/screens/saerch_screen.dart';
import 'package:shoapsmart_useers_laerm/widgets/subtitle_text.dart';

class CatogresRoundedProduct extends StatelessWidget {
  const CatogresRoundedProduct({
    super.key,
    required this.name,
    required this.image,
  });
  final String name, image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          await Navigator.pushNamed(context, SaerchScreen.routName,arguments: name);
        },
      child: Column(
        
        children: [
          Image.asset(
            image,
            height: 50,
            width: 50,
          ),
          SizedBox(
            height: 10,
          ),
          Flexible(
            child: SubtitleText(
              lable: name,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        
        ],
      ),
    );
  }
}
