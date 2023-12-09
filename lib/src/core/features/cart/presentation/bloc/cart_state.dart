// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cart_bloc.dart';

enum DisplayCartProductStatus { initial, loading, success, failure }

class CartState extends Equatable {
  final DisplayCartProductStatus cartStatus;
  final List<DisplayCartModel>? cartProducts;
  final String? message;
  final double? totalPrice;
  const CartState({
    required this.cartStatus,
    this.cartProducts,
    this.message,
    this.totalPrice,
  });

  @override
  List<Object?> get props => [
        cartStatus,
        cartProducts,
        message,
        totalPrice,
      ];

  CartState copyWith({
    DisplayCartProductStatus? cartStatus,
    List<DisplayCartModel>? cartProducts,
    String? message,
    double? totalPrice,
  }) {
    return CartState(
      cartStatus: cartStatus ?? this.cartStatus,
      cartProducts: cartProducts ?? this.cartProducts,
      message: message ?? this.message,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  factory CartState.initial() => const CartState(
      cartStatus: DisplayCartProductStatus.initial,
      cartProducts: [],
      totalPrice: 0);
}
