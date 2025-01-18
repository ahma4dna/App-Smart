import 'package:flutter/material.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shoapsmart_useers_laerm/conest/app_conestant.dart';
import 'package:shoapsmart_useers_laerm/screens/inner_secreen/product_deatels.dart';
import 'package:shoapsmart_useers_laerm/widgets/subtitle_text.dart';
import 'package:shoapsmart_useers_laerm/widgets/title_text.dart';

class OrderWidget extends StatelessWidget {
  const OrderWidget({super.key});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () async {
        await Navigator.pushNamed(context, ProductDeatels.routeName);
      },
      child: FittedBox(
        child: IntrinsicWidth(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: FancyShimmerImage(
                    imageUrl: AppConestant.ImageStatic,
                    height: size.height * 0.2,
                    width: size.height * 0.2,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              IntrinsicWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: size.width * 0.6,
                          child: TitleText(
                            lable: 'Title' * 10,
                            maxLine: 2,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            IconlyBold.delete,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
                      children: [
                        TitleText(lable: "Price:"),
                        Flexible(
                          child: SubtitleText(
                            lable: '  20 \$',
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
                      children: [
                        TitleText(lable: "Qty:"),
                        Flexible(
                          child: SubtitleText(
                            lable: '  10',
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
