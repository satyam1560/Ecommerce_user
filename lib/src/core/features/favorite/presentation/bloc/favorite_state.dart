// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'favorite_bloc.dart';

enum FavoriteStateStatus { initial, loading, success, failure }

class FavoriteState extends Equatable {
  final FavoriteStateStatus status;
  final List<AddToWishlistModel>? products;
  final List<String>? productIds;
  const FavoriteState({
    required this.status,
    this.products,
    this.productIds = const [],
  });

  FavoriteState copyWith({
    FavoriteStateStatus? status,
    List<AddToWishlistModel>? products,
    List<String>? productIds,
  }) {
    return FavoriteState(
      status: status ?? this.status,
      products: products ?? this.products,
      productIds: productIds ?? this.productIds,
    );
  }

  factory FavoriteState.initial() => const FavoriteState(
        status: FavoriteStateStatus.initial,
        products: [],
      );
  @override
  List<Object?> get props => [status, products, productIds];
}
