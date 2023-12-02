// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cart_bloc.dart';

enum AddToCartStatus { initial, loading, success, failure }

class CartState extends Equatable {
  final AddToCartStatus cartStatus;
  final String? failure;
  final String? productId;
  final List<String> cartProductIds; // New field
  final List<CartModel>? cartProduct;
  final List<CartProduct>? cartproducts;

  const CartState(
      {required this.cartStatus,
      required this.failure,
      this.productId,
      this.cartProductIds = const [], // Initialize to an empty list
      required this.cartProduct,
      this.cartproducts});

  CartState copyWith({
    AddToCartStatus? cartStatus,
    String? failure,
    String? productId,
    List<String>? cartProductIds,
    List<CartModel>? cartProduct,
    List<CartProduct>? cartproducts,
  }) {
    return CartState(
      cartproducts: cartproducts ?? this.cartproducts,
      cartStatus: cartStatus ?? this.cartStatus,
      failure: failure ?? this.failure,
      productId: productId ?? this.productId,
      cartProductIds: cartProductIds ?? this.cartProductIds,
      cartProduct: cartProduct ?? this.cartProduct,
    );
  }

  factory CartState.initial() => const CartState(
        cartproducts: [],
        cartProduct: [],
        cartStatus: AddToCartStatus.initial,
        failure: '',
        productId: '',
        cartProductIds: [], // Initialize to an empty list
      );

  @override
  List<Object?> get props => [
        cartStatus,
        failure,
        productId,
        cartProductIds,
        cartProduct,
        cartproducts
      ];
}
