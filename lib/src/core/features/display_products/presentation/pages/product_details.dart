import 'package:ecommerce_user/src/core/features/display_products/data/models/product_model.dart';
import 'package:ecommerce_user/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../../../../../../utils/constants/colors.dart';
import '../../../cart/presentation/widgets/favorite_cart.dart';
import '../widgets/discount.dart';

class ProductDetails extends StatelessWidget {
  final Product product;

  const ProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      product.productImgUrl!,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                DiscountTag(product: product),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text(
              product.title!,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text(product.description!,
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: TSizes.defaultSpace),
            Text(
              '₹ ${double.parse(product.productPrice.toString())}',
              style: const TextStyle(
                decoration: TextDecoration.lineThrough,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '₹ ${double.parse(product.sellingPrice.toString())}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: TColors.buttonPrimary,
                  ),
                ),
                const Spacer(),
                FavoriteAndCart(
                  productId: product.id,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
