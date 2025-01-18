import 'package:flutter/material.dart';
import 'package:shoapsmart_useers_laerm/services/image_manger.dart';
import 'package:shoapsmart_useers_laerm/widgets/subtitle_text.dart';

class MehtodeMyApp {
  static Future<void> showErorrORwarnigDialog({
    required BuildContext context,
    required String subTile,
    required Function fce,
    bool isErorr = true,
  }) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                AssetsManager.warning,
                height: 60,
                width: 60,
              ),
              const SizedBox(
                height: 16,
              ),
              SubtitleText(lable: subTile),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                     visible: !isErorr,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const SubtitleText(
                        lable: "Cancel",
                        color: Colors.green,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  TextButton(
                    onPressed: () {
                      fce();
                      Navigator.pop(context);
                    },
                    child: const SubtitleText(
                      lable: "OK",
                      color: Colors.red,
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
