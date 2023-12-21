import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/add_to_wishlist.dart';

class WishlistRepo {
  CollectionReference wishlist =
      FirebaseFirestore.instance.collection('wishlist');
  CollectionReference products =
      FirebaseFirestore.instance.collection('products');

  /// method [addItemToWishlist] will store items to firebase on pressing favorite button
  Future<void> addItemToWishlist(
      {required AddToWishlistModel addToWishlistModel}) {
    return wishlist
        .doc(addToWishlistModel.userId)
        .collection('wishlistProducts')
        .doc(addToWishlistModel.productId)
        .set(addToWishlistModel.toMap())
        .then((_) {
      return addToWishlistModel;
    }).catchError((e) {
      print('catch error${e.toString()}');
      throw e;
    });
  }

  /// method [getProductById] fetch details of product which are there in wishlist screen by Product id.
  Future<List<AddToWishlistModel>> getWishlistItems(
      {required String userId}) async {
    List<AddToWishlistModel> wishlistItems = [];

    QuerySnapshot querySnapshot =
        await wishlist.doc(userId).collection('wishlistProducts').get();

    for (var doc in querySnapshot.docs) {
      wishlistItems
          .add(AddToWishlistModel.fromMap(doc.data() as Map<String, dynamic>));
    }

    return wishlistItems;
  }

  /// method [removeFromWishlist] simply delete product from wishlist
  /// while performing dismissible
  void removeFromWishlist(
      {required String productId, required String userId}) async {
    CollectionReference wishlistProducts =
        wishlist.doc(userId).collection('wishlistProducts');
    QuerySnapshot querySnapshot = await wishlistProducts.get();
    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      if (doc.id == productId) {
        await wishlistProducts.doc(doc.id).delete();
        break;
      }
    }
  }
}
