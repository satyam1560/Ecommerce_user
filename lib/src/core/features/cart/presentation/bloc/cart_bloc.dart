import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/display_cart_model.dart';
import '../../data/repositories/display_cart_repo.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  DisplayCartRepo displayCartRepo = DisplayCartRepo();
  CartBloc() : super(CartState.initial()) {
    on<DisplayCartProductEvent>(
      (event, emit) async {
        try {
          emit(state.copyWith(cartStatus: DisplayCartProductStatus.loading));
          await updateCartProducts(event.userId!, emit);
        } catch (e) {
          emit(state.copyWith(
              cartStatus: DisplayCartProductStatus.failure,
              message: e.toString()));
        }
      },
    );

    on<RemoveProductFromCartEvent>(
      (event, emit) async {
        try {
          await displayCartRepo.removeFromCart(
              productId: event.productId!, userId: event.userId!);
          emit(state.copyWith(cartStatus: DisplayCartProductStatus.loading));
          await updateCartProducts(event.userId!, emit);
        } catch (e) {
          emit(state.copyWith(
              cartStatus: DisplayCartProductStatus.failure,
              message: e.toString()));
        }
      },
    );

    on<EmptyCart>(((event, emit) {
      displayCartRepo.emptyCart(userId: event.userId!);
      emit(state.copyWith(cartStatus: DisplayCartProductStatus.loading));
      // emit(CartState.initial());
      emit(state.copyWith(
          cartStatus: DisplayCartProductStatus.success,
          cartProducts: [],
          totalPrice: 0));
    }));
  }

  Future<void> updateCartProducts(
      String userId, Emitter<CartState> emit) async {
    List<DisplayCartModel> cartProducts =
        await displayCartRepo.displayToCart(userId: userId);
    num totalPrice = 0;
    for (var element in cartProducts) {
      totalPrice += (element.price! * element.quantity!);
    }
    // print('totalPrice$totalPrice');
    emit(state.copyWith(
        cartStatus: DisplayCartProductStatus.success,
        cartProducts: cartProducts,
        totalPrice: totalPrice as double));
  }
}
