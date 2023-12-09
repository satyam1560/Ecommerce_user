part of 'add_to_cart_bloc.dart';

sealed class AddToCartState extends Equatable {
  const AddToCartState();

  @override
  List<Object?> get props => [];
}

class AddToCartInitial extends AddToCartState {}

class AddToCartLoading extends AddToCartState {}

class AddToCartSuccess extends AddToCartState {
  final List<String> cartItems;

  const AddToCartSuccess(this.cartItems);

  @override
  List<Object> get props => [cartItems];
}

class AddToCartFailure extends AddToCartState {
  final String error;

  const AddToCartFailure(this.error);

  @override
  List<Object?> get props => [error];
}
