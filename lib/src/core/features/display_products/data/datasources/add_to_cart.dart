import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/add_to_cart_model.dart';

class AddToCart {
  CollectionReference carts = FirebaseFirestore.instance.collection('carts');

  Future<AddToCartModel> addToCart({required AddToCartModel addToCartModel}) {
    return carts
        .doc(addToCartModel.userId)
        .collection('products')
        .doc(addToCartModel.productId)
        .set({'quantity': addToCartModel.quantity}).then((_) {
      return addToCartModel;
    }).catchError((e) {
      throw Exception(e.toString());
    });
  }
}
