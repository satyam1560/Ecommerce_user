// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class AddToCartEvent extends CartEvent {
  final String? currentUserId;
  final String? productId;
  final int? quantity;
  const AddToCartEvent({
    this.currentUserId,
    this.productId,
    this.quantity,
  });
  @override
  List<Object?> get props => [
        currentUserId,
        productId,
        quantity,
      ];
}

class DisplayProductInCartEvent extends CartEvent {
  final String? currentUserId;
  const DisplayProductInCartEvent({
    required this.currentUserId,
  });
  @override
  List<Object?> get props => [
        currentUserId,
      ];
}

class RemoveFromCartEvent extends CartEvent {
  final String? currentUserId;
  final String? productId;
  const RemoveFromCartEvent({
    this.currentUserId,
    this.productId,
  });
  @override
  List<Object?> get props => [currentUserId, productId];
}
