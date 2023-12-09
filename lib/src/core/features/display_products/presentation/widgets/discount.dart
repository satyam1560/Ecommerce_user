import 'package:ecommerce_user/src/core/features/display_products/data/models/product_model.dart';
import 'package:flutter/material.dart';

import 'custom_button.dart';

class DiscountTag extends StatelessWidget {
  final Product product;
  const DiscountTag({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final originalPrice = product.productPrice as num;
    final discountedPrice = product.sellingPrice as num;

    final discount = (originalPrice - discountedPrice) / originalPrice;
    final discountPercentage = (discount * 100).ceil();

    return Positioned(
      right: 0,
      child: CustomButton(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        text: '$discountPercentage%',
        backgroundColor: const Color.fromARGB(238, 243, 176, 43),
        textColor: Colors.white,
      ),
    );
  }
}
