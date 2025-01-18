import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shoapsmart_useers_laerm/moeals/wishlist_model.dart';
import 'package:shoapsmart_useers_laerm/provider/wishlist_provider.dart';

class HartBottunWidget extends StatefulWidget {
  const HartBottunWidget({super.key,   this.size=25, required this.productId});

  final double size;
  final String productId;
  @override
  State<HartBottunWidget> createState() => _HartBottunWidgetState();
}

class _HartBottunWidgetState extends State<HartBottunWidget> {
  @override
  
  Widget build(BuildContext context) {
    final  wishlistProvider =Provider.of<WishlistProvider>(context);
    return IconButton(
      onPressed: () {
        wishlistProvider.addOrRemoveWislist(productId: widget.productId);
      },
      icon: Icon(wishlistProvider.isProductInWislist(productId: widget.productId)?
        IconlyBold.heart:IconlyLight.heart,
        color: wishlistProvider.isProductInWislist(productId: widget.productId)?Colors.red:Colors.grey,
        size: widget.size,
      ),
    );
  }
}
