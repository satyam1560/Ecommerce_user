import 'package:ecommerce_user/src/core/features/favorite/presentation/bloc/favorite_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddToWishlistIcon extends StatelessWidget {
  const AddToWishlistIcon(
      {super.key, required this.onPressed, required this.productId});
  final Function()? onPressed;
  final String productId;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          if (state.status == FavoriteStateStatus.initial ||
              !state.productIds!.contains(productId)) {
            return const Icon(Icons.favorite_outline);
          } else if (state.status == FavoriteStateStatus.success &&
              state.productIds!.contains(productId)) {
            return const Icon(Icons.favorite);
          }
          return Container();
        },
      ),
    );
  }
}
