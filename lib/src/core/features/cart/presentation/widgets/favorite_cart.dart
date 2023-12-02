import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../authentication/presentation/bloc/auth/authentication_bloc.dart';
import '../../../display_products/data/datasources/product_repo.dart';
import '../../../display_products/data/models/product_model.dart';
import '../bloc/cart_bloc.dart';

class FavoriteAndCart extends StatefulWidget {
  FavoriteAndCart({Key? key, required this.productId}) : super(key: key);
  String? productId;
  // int? itemqnty;

  @override
  State<FavoriteAndCart> createState() => _FavoriteAndCartState();
}

class _FavoriteAndCartState extends State<FavoriteAndCart> {
  List<String> cartProductIds = [];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            // Implement favorite button functionality if needed
          },
          icon: const Icon(Icons.favorite_border_outlined),
        ),
        BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            IconData cartIcon = state.cartProductIds.contains(widget.productId)
                ? Icons.shopping_cart
                : Icons.shopping_cart_outlined;

            return IconButton(
              onPressed: () async {
                String? currentUserId =
                    context.read<AuthBloc>().authRepository.currentUserId;

                ProductRepository productRepository = ProductRepository();
                Product? product =
                    await productRepository.getProductById(widget.productId!);

                BlocProvider.of<CartBloc>(context).add(AddToCartEvent(
                    currentUserId: currentUserId,
                    productId: product!.id,
                    quantity: 1));
              },
              icon: Icon(cartIcon),
            );
          },
        ),
      ],
    );
  }
}
