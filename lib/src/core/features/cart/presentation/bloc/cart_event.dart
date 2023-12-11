// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class DisplayCartProductEvent extends CartEvent {
  final String? userId;
  const DisplayCartProductEvent({
    required this.userId,
  });
  @override
  List<Object?> get props => [userId];
}

class RemoveProductFromCartEvent extends CartEvent {
  final String? userId;
  final String? productId;
  final double? productPrice;
  const RemoveProductFromCartEvent({
    this.userId,
    this.productId,
    this.productPrice,
  });
  @override
  List<Object?> get props => [userId, productId, productPrice];
}

class EmptyCart extends CartEvent {
  final String? userId;
  const EmptyCart({required this.userId});
  @override
  List<Object?> get props => [userId];
}
