// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object?> get props => [];
}

class AddProductToWishlist extends FavoriteEvent {
  final AddToWishlistModel addToWishlistModel;
  const AddProductToWishlist({
    required this.addToWishlistModel,
  });

  @override
  List<Object?> get props => [addToWishlistModel];
}

class DisplayProductAtWishlist extends FavoriteEvent {
  final String userId;
  const DisplayProductAtWishlist({
    required this.userId,
  });
  @override
  List<Object?> get props => [userId];
}

class RemoveProductFromWishlist extends FavoriteEvent {
  final String userId;
  final String productId;
  const RemoveProductFromWishlist(
      {required this.userId, required this.productId});
  @override
  List<Object?> get props => [userId, productId];
}

class MoveToCart extends FavoriteEvent {
  final AddToCartModel addToCartModel;
  final String productId;
  final String userId;

  const MoveToCart({
    required this.addToCartModel,
    required this.productId,
    required this.userId,
  });

  @override
  List<Object?> get props => [addToCartModel, productId, userId];
}
