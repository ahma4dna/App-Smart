// ignore_for_file: file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickeimageWidget extends StatelessWidget {
  const PickeimageWidget(
      {super.key, required this.pickedImage, required this.function});
  final XFile? pickedImage;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: pickedImage == null
                ? Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  )
                : Image.file(
                    File(pickedImage!.path),
                    fit: BoxFit.fill,
                  ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Material(
            color: Colors.lightBlue,
            borderRadius: BorderRadius.circular(12),
            
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                function();
              },
              // ignore: prefer_const_constructors
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                // ignore: prefer_const_constructors
                child: Icon(
                  Icons.image,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
