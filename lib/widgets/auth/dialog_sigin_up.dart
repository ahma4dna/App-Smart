import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shoapsmart_useers_laerm/services/image_manger.dart';
import 'package:shoapsmart_useers_laerm/widgets/subtitle_text.dart';
import 'package:shoapsmart_useers_laerm/widgets/title_text.dart';

class DialogSiginUp {
  static Future<void> showAddImageNewUserDialog({
    required BuildContext context,
    required Function cameraFun,
    required Function gallaryFun,
    required Function removeFun,
  }) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          // ignore: prefer_const_constructors
          title: Center(child: const TitleText(lable: "Choose option")),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () {
                  cameraFun();
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                label: const SubtitleText(
                  lable: "Camera",
                  color: Colors.purple,
                ),
                icon: const Icon(
                  IconlyBold.camera,
                  color: Colors.purple,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextButton.icon(
                onPressed: () {
                  gallaryFun();
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                label: const SubtitleText(
                  lable: "Gallery",
                  color: Colors.purple,
                ),
                icon: const Icon(
                  IconlyBold.image2,
                  color: Colors.purple,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextButton.icon(
                onPressed: () {
                  removeFun();
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                label: const SubtitleText(
                  lable: "Remove",
                  color: Colors.purple,
                ),
                icon: const Icon(
                  IconlyLight.dangerCircle,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
