import 'package:bloc/bloc.dart';
import 'package:ecommerce_user/src/core/features/favorite/data/datasources/wishlist_repo.dart';
import 'package:equatable/equatable.dart';

import '../../../display_products/data/datasources/add_to_cart.dart';
import '../../../display_products/data/models/add_to_cart_model.dart';
import '../../data/models/add_to_wishlist.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  WishlistRepo wishlistRepo = WishlistRepo();
  FavoriteBloc() : super(FavoriteState.initial()) {
    on<AddProductToWishlist>((event, emit) async {
      emit(state.copyWith(
        status: FavoriteStateStatus.loading,
      ));
      wishlistRepo.addItemToWishlist(
          addToWishlistModel: event.addToWishlistModel);

      emit(state.copyWith(
        status: FavoriteStateStatus.success,
        productIds: List.from(state.productIds as Iterable)
          ..add(event.addToWishlistModel.productId!),
      ));
    });

    on<DisplayProductAtWishlist>((event, emit) async {
      emit(state.copyWith(
        status: FavoriteStateStatus.loading,
      ));
      List<AddToWishlistModel> wishlistProduct =
          await wishlistRepo.getWishlistItems(userId: event.userId);

      emit(state.copyWith(
        status: FavoriteStateStatus.success,
        products: wishlistProduct,
      ));
    });

    on<RemoveProductFromWishlist>((event, emit) {
      wishlistRepo.removeFromWishlist(
          productId: event.productId, userId: event.userId);

      List<String> updatedProductIds = List.from(state.productIds as Iterable);
      updatedProductIds.remove(event.productId);

      List<AddToWishlistModel> updatedProducts =
          List.from(state.products as Iterable);
      updatedProducts
          .removeWhere((product) => product.productId == event.productId);

      emit(state.copyWith(
        status: FavoriteStateStatus.success,
        productIds: updatedProductIds,
        products: updatedProducts,
      ));
    });

    on<MoveToCart>((event, emit) async {
      add(RemoveProductFromWishlist(
          productId: event.productId, userId: event.userId));

      emit(state.copyWith(
        status: FavoriteStateStatus.loading,
      ));
      AddToCart addToCart = AddToCart();

      await addToCart.addToCart(addToCartModel: event.addToCartModel);

      emit(state.copyWith(
        status: FavoriteStateStatus.success,
      ));
    });
  }
}
