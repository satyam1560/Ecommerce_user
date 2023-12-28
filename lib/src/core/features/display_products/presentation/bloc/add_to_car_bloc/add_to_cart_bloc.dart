import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/datasources/add_to_cart.dart';
import '../../../data/models/add_to_cart_model.dart';

part 'add_to_cart_event.dart';
part 'add_to_cart_state.dart';

class AddToCartBloc extends Bloc<AddToCartEvent, AddToCartState> {
  AddToCart addToCartrepo = AddToCart();
  List<String> cartItems = [];

  AddToCartBloc() : super(AddToCartInitial()) {
    on<AddProductToCartEvent>((event, emit) async {
      emit(AddToCartLoading());
      try {
        AddToCartModel itemsAddedToCart =
            await addToCartrepo.addToCart(addToCartModel: event.addToCartModel);
        cartItems.add(itemsAddedToCart.productId!);
        emit(AddToCartSuccess(
            cartItems)); // Emit success state after adding to cart
      } catch (e) {
        emit(AddToCartFailure(
            e.toString())); // Emit failure state if an error occurs
      }
    });
  }
}
