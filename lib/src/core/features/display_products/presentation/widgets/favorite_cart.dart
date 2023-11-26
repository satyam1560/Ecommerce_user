import 'package:flutter/material.dart';

class FavoriteAndCart extends StatelessWidget {
  const FavoriteAndCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.favorite_border_outlined),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.shopping_cart_outlined),
        )
      ],
    );
  }
}
