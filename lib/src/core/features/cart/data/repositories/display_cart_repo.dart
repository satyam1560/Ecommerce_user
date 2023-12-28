import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../models/display_cart_model.dart';

class DisplayCartRepo {
  final carts = FirebaseFirestore.instance.collection('carts');
  final products = FirebaseFirestore.instance.collection('products');

  Future<List<DisplayCartModel>> displayToCart({required String userId}) async {
    List<DisplayCartModel> cartItems = [];

    try {
      final cartSnapshot = await carts.doc(userId).collection('products').get();
      final productDocs = cartSnapshot.docs;

      await Future.wait(productDocs.map((productDoc) async {
        final productId = productDoc.id;
        final productSnapshot = await products.doc(productId).get();

        if (productSnapshot.exists) {
          final productData = productSnapshot.data() as Map<String, dynamic>;
          final title = productData['title'] ?? 'Default Title';
          final price =
              (productData['sellingPrice'] as num?)?.toDouble() ?? 0.0;
          final imageUrl = productData['productImgUrl'] ?? '';
          final quantity = productDoc.get('quantity') ?? 0;

          cartItems.add(DisplayCartModel.fromMap({
            'productId': productId,
            'quantity': quantity,
            'title': title,
            'price': price,
            'imageUrl': imageUrl,
            'userId': userId,
          }));
        } else {
          debugPrint('Product with ID $productId does not exist');
        }
      }));
    } catch (e) {
      debugPrint('ERROR : ${e.toString()}');
    }

    return cartItems;
  }

  Future<void> removeFromCart(
      {required String productId, required String userId}) {
    return carts
        .doc(userId)
        .collection('products')
        .doc(productId)
        .delete()
        .then((_) {
      debugPrint('Product removed from cart successfully');
    }).catchError((e) {
      debugPrint('Error removing product from cart: ${e.toString()}');
      throw e;
    });
  }

  void emptyCart({required String userId}) async {
    CollectionReference productsCollection =
        carts.doc(userId).collection('products');

    QuerySnapshot querySnapshot = await productsCollection.get();

    WriteBatch batch = FirebaseFirestore.instance.batch();

    for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
      batch.delete(documentSnapshot.reference);
    }

    await batch.commit();

    await carts.doc(userId).delete();
  }
}
