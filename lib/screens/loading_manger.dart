import 'package:flutter/material.dart';

class LoadingManger extends StatelessWidget {
  const LoadingManger(
      {super.key, required this.isloading, required this.chaild});
  final bool isloading;
  final Widget chaild;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        chaild,
        if (isloading) ...[
          Container(
            color: Colors.black.withOpacity(0.7),
          ),
          const Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          ),
        ]
      ],
    );
  }
}
