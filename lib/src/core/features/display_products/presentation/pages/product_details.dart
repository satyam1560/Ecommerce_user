import 'package:ecommerce_user/src/core/features/display_products/data/models/product_model.dart';
import 'package:ecommerce_user/src/core/features/display_products/presentation/widgets/quantity.dart';
import 'package:ecommerce_user/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../utils/constants/colors.dart';
import '../../../favorite/data/models/add_to_wishlist.dart';
import '../../../favorite/presentation/bloc/favorite_bloc.dart';
import '../../../favorite/presentation/widgets/favorite_button.dart';
import '../../data/models/add_to_cart_model.dart';
import '../bloc/add_to_car_bloc/add_to_cart_bloc.dart';
import '../widgets/add_to_cart_button.dart';
import '../widgets/discount.dart';

class ProductDetails extends StatefulWidget {
  final Product product;
  final String userId;

  const ProductDetails(
      {super.key, required this.product, required this.userId});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int? selectedQuantity = 1;

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
                      widget.product.productImgUrl!,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                DiscountTag(product: widget.product),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text(
              widget.product.title!,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text(widget.product.description!,
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: TSizes.defaultSpace),
            Text(
              '₹ ${double.parse(widget.product.productPrice.toString())}',
              style: const TextStyle(
                decoration: TextDecoration.lineThrough,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '₹ ${double.parse(widget.product.sellingPrice.toString())}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: TColors.buttonPrimary,
                  ),
                ),
                const Spacer(),

                Quantity(onQuantitySelected: (int value) {
                  selectedQuantity = value;
                }),
                //favorite button
                AddToWishlistIcon(
                  onPressed: () {
                    BlocProvider.of<FavoriteBloc>(context).add(
                      AddProductToWishlist(
                        addToWishlistModel: AddToWishlistModel(
                          productId: widget.product.id,
                          userId: widget.userId,
                          quantity: 1,
                          imageUrl: widget.product.productImgUrl,
                          title: widget.product.title,
                          price: widget.product.sellingPrice as double,
                        ),
                      ),
                    );
                  },
                  productId: widget.product.id ?? '',
                ),
                //add to cart button
                AddToCartIcon(
                    onPressed: () {
                      submitWithQuantity(context);
                    },
                    productId: widget.product.id!)
              ],
            ),
          ],
        ),
      ),
    );
  }

  void submitWithQuantity(BuildContext context) {
    context.read<AddToCartBloc>().add(
          AddProductToCartEvent(
            addToCartModel: AddToCartModel(
              productId: widget.product.id,
              userId: widget.userId,
              quantity: selectedQuantity,
            ),
          ),
        );
    // print('button pressed');
  }
}
