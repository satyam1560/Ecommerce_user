import 'package:ecommerce_user/src/core/features/cart/data/datasources/cart_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../authentication/presentation/bloc/auth/authentication_bloc.dart';
import '../bloc/cart_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartRepo cartRepo = CartRepo();
  static String uid = '';
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Accessing the AuthBloc after the widget is built
      final authUserId =
          BlocProvider.of<AuthBloc>(context).authRepository.currentUserId;
      print('authUserId $authUserId');
      uid = authUserId!;

      // Dispatching the DisplayProductInCartEvent with the authUserId
      BlocProvider.of<CartBloc>(context)
          .add(DisplayProductInCartEvent(currentUserId: authUserId));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    BlocBuilder<CartBloc, CartState>(
                      builder: (context, state) {
                        if (state.cartStatus == AddToCartStatus.loading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state.cartStatus ==
                            AddToCartStatus.success) {
                          final cartProduct = state.cartproducts;
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: cartProduct!.length,
                            itemBuilder: (context, index) {
                              var productcart = cartProduct[index];

                              return Dismissible(
                                  key: UniqueKey(),
                                  onDismissed: (direction) {
                                    BlocProvider.of<CartBloc>(context).add(
                                      RemoveFromCartEvent(
                                        currentUserId: uid,
                                        productId: productcart.id,
                                      ),
                                    );
                                  },
                                  background: Container(
                                    color: Colors.red,
                                    alignment: Alignment.centerRight,
                                    padding: const EdgeInsets.only(right: 16.0),
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                  ),
                                  child: Card(
                                    child: ListTile(
                                      leading: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.network(
                                          productcart.productImgUrl ?? '',
                                          filterQuality: FilterQuality.low,
                                        ),
                                      ),
                                      title: Text(
                                        productcart.title ?? '',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                      subtitle: Text(
                                        '₹ ${productcart.sellingPrice}',
                                      ),

                                      // Other properties go here
                                    ),
                                  ));
                            },
                          );
                        } else if (state.cartStatus ==
                            AddToCartStatus.initial) {
                          return const Center(
                            child: Text('Cart is Empty!'),
                          );
                        } else {
                          // Handle error state
                          return const Text('Error loading cart products');
                        }
                      },
                    ),
                    //! here below I will implement the total with proceed to pay widget
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
