import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/add_to_car_bloc/add_to_cart_bloc.dart';

class AddToCartIcon extends StatelessWidget {
  void Function()? onPressed;
  final String productId;
  AddToCartIcon({super.key, required this.onPressed, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddToCartBloc, AddToCartState>(
      builder: (context, state) {
        return IconButton(
          icon: state is AddToCartSuccess && state.cartItems.contains(productId)
              ? const Icon(Icons.shopping_cart)
              : const Icon(Icons.shopping_cart_outlined),
          onPressed: onPressed,
        );
      },
    );
  }
}
