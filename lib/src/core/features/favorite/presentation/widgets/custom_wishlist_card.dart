// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce_user/src/core/features/favorite/presentation/bloc/favorite_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../display_products/data/models/add_to_cart_model.dart';

class CustomWishlistCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final double price;
  final int quantity;
  final String productId;
  final String userId;

  const CustomWishlistCard({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.quantity,
    required this.productId,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Title: $title',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text('Price: $price'),
                Row(
                  children: [
                    Text('Qty: $quantity'),
                    const SizedBox(width: 50),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 7)),
                      onPressed: () {
                        BlocProvider.of<FavoriteBloc>(context).add(MoveToCart(
                            addToCartModel: AddToCartModel(
                                productId: productId,
                                userId: userId,
                                quantity: quantity),
                            productId: productId,
                            userId: userId));
                      },
                      child: const Text('Move To Cart'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
