import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/favorite_bloc.dart';
import '../widgets/custom_wishlist_card.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  User currentUser = FirebaseAuth.instance.currentUser!;
  @override
  void initState() {
    BlocProvider.of<FavoriteBloc>(context)
        .add(DisplayProductAtWishlist(userId: currentUser.uid));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Favorites'),
        ),
        body: BlocBuilder<FavoriteBloc, FavoriteState>(
          builder: (context, state) {
            if (state.status == FavoriteStateStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.status == FavoriteStateStatus.success) {
              final wishlistProduct = state.products;
              return ListView.builder(
                  itemCount: wishlistProduct!.length,
                  itemBuilder: (context, index) {
                    final productList = wishlistProduct[index];
                    return Dismissible(
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        BlocProvider.of<FavoriteBloc>(context).add(
                            RemoveProductFromWishlist(
                                userId: currentUser.uid,
                                productId: productList.productId!));

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                '${productList.title} removed from wishlist'),
                          ),
                        );
                      },
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20.0),
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      key: UniqueKey(),
                      child: CustomWishlistCard(
                        userId: currentUser.uid,
                        productId: productList.productId!,
                        title: productList.title!,
                        price: productList.price!,
                        quantity: productList.quantity!,
                        imageUrl: productList.imageUrl!,
                      ),
                    );
                  });
            }
            return Container();
          },
        ));
  }
}
