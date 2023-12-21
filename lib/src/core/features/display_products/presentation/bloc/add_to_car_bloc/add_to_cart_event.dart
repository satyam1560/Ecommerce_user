part of 'add_to_cart_bloc.dart';

sealed class AddToCartEvent extends Equatable {
  const AddToCartEvent();

  @override
  List<Object?> get props => [];
}

class AddProductToCartEvent extends AddToCartEvent {
  final AddToCartModel addToCartModel;
  const AddProductToCartEvent({required this.addToCartModel});
  @override
  List<Object?> get props => [addToCartModel];
}
