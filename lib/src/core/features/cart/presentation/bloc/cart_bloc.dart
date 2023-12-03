import 'package:bloc/bloc.dart';
import 'package:ecommerce_user/src/core/features/cart/data/datasources/cart_repo.dart';
import 'package:ecommerce_user/src/core/features/cart/data/models/cartProduct_model.dart';
import 'package:equatable/equatable.dart';

import '../../../display_products/data/datasources/product_repo.dart';
import '../../data/models/cart_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

// class CartBloc extends Bloc<CartEvent, CartState> {
//   CartRepo cartRepo = CartRepo();
//   ProductRepository productRepository = ProductRepository();

//   CartBloc() : super(CartState.initial()) {
//     on<AddToCartEvent>((event, emit) async {
//       emit(state.copyWith(cartStatus: AddToCartStatus.loading));
//       await cartRepo.addToCart(
//         userId: event.currentUserId!,
//         productId: event.productId!,
//         quantity: event.quantity!,
//       );
//       List<String> updatedCartProductIds = List.from(state.cartProductIds)
//         ..add(event.productId!);
//       emit(state.copyWith(
//           cartStatus: AddToCartStatus.success,
//           productId: event.productId,
//           cartProductIds: updatedCartProductIds));
//     });
//     on<DisplayProductInCartEvent>((event, emit) async {
//       try {
//         emit(state.copyWith(cartStatus: AddToCartStatus.loading));
//         final cartProducts =
//             await cartRepo.getCartProducts(userId: event.currentUserId!);

//         double totalPrice = 0;
//         for (var product in cartProducts) {
//           totalPrice += product.sellingPrice!.toDouble();
//         }

//         emit(state.copyWith(
//             cartStatus: AddToCartStatus.success,
//             cartproducts: cartProducts,
//             totalPrice: totalPrice));
//       } catch (e) {
//         emit(state.copyWith(
//             cartStatus: AddToCartStatus.loading, failure: e.toString()));
//       }
//     });

//     // on<RemoveFromCartEvent>(
//     //   (event, emit) async {
//     //     await cartRepo.removeFromCart(
//     //         userId: event.currentUserId!, productId: event.productId!);
//     //     // emit(state.copyWith(cartStatus: AddToCartStatus.loading));

//     //     emit(state.copyWith(cartStatus: AddToCartStatus.success));
//     //   },
//     // );
//     on<RemoveFromCartEvent>(
//       (event, emit) async {
//         try {
//           await cartRepo.removeFromCart(
//               userId: event.currentUserId!, productId: event.productId!);

//           // Retrieve the updated cart products
//           final cartProducts =
//               await cartRepo.getCartProducts(userId: event.currentUserId!);

//           // Calculate the new total price based on the updated cart
//           double newTotalPrice = 0;
//           if (cartProducts.isNotEmpty) {
//             for (var product in cartProducts) {
//               newTotalPrice += product.sellingPrice!.toDouble();
//             }
//           }

//           // Emit the new state with updated cart and total price
//           emit(state.copyWith(
//             cartStatus: AddToCartStatus.success,
//             cartproducts: cartProducts,
//             totalPrice: newTotalPrice,
//           ));
//         } catch (e) {
//           emit(state.copyWith(
//             cartStatus: AddToCartStatus.loading,
//             failure: e.toString(),
//           ));
//         }
//       },
//     );
//   }
// }
class CartBloc extends Bloc<CartEvent, CartState> {
  CartRepo cartRepo = CartRepo();
  ProductRepository productRepository = ProductRepository();

  CartBloc() : super(CartState.initial()) {
    on<AddToCartEvent>((event, emit) async {
      emit(state.copyWith(cartStatus: AddToCartStatus.loading));
      await cartRepo.addToCart(
        userId: event.currentUserId!,
        productId: event.productId!,
        quantity: event.quantity!,
      );
      List<String> updatedCartProductIds = List.from(state.cartProductIds)
        ..add(event.productId!);
      emit(state.copyWith(
          cartStatus: AddToCartStatus.success,
          productId: event.productId,
          cartProductIds: updatedCartProductIds));
    });
    on<DisplayProductInCartEvent>((event, emit) async {
      try {
        emit(state.copyWith(cartStatus: AddToCartStatus.loading));
        final cartProducts =
            await cartRepo.getCartProducts(userId: event.currentUserId!);

        double totalPrice = state.totalPrice;
        for (var product in cartProducts) {
          totalPrice += product.sellingPrice!.toDouble();
        }

        emit(state.copyWith(
            cartStatus: AddToCartStatus.success,
            cartproducts: cartProducts,
            totalPrice: totalPrice));
      } catch (e) {
        emit(state.copyWith(
            cartStatus: AddToCartStatus.failure, failure: e.toString()));
      }
    });

    on<RemoveFromCartEvent>(
      (event, emit) async {
        try {
          await cartRepo.removeFromCart(
              userId: event.currentUserId!, productId: event.productId!);

          // Retrieve the updated cart products
          final cartProducts =
              await cartRepo.getCartProducts(userId: event.currentUserId!);

          // Calculate the new total price based on the updated cart
          double newTotalPrice = state.totalPrice;
          if (cartProducts.isNotEmpty) {
            for (var product in cartProducts) {
              newTotalPrice -= product.sellingPrice!.toDouble();
            }
          }

          // Emit the new state with updated cart and total price
          emit(state.copyWith(
            cartStatus: AddToCartStatus.success,
            cartproducts: cartProducts,
            totalPrice: newTotalPrice,
          ));
        } catch (e) {
          emit(state.copyWith(
            cartStatus: AddToCartStatus.failure,
            failure: e.toString(),
          ));
        }
      },
    );
  }
}
