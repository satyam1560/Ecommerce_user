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
    final discountPercentage =
        (discount * 100).ceil(); // Format to two decimal places

    return Positioned(
      right: 0,
      child: CustomButton(
        margin: const EdgeInsets.all(10),
        // Styling for the discount tag button.
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        // Text to display the discount percentage.
        text: '$discountPercentage%',
        // Background color for the discount tag.
        backgroundColor: const Color.fromARGB(238, 243, 176, 43),
        // Text color for the discount tag.
        textColor: Colors.white,
      ),
    );
  }
}
