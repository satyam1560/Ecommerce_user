import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/cartProduct_model.dart';
import '../models/cart_model.dart';

class CartRepo {
  final CollectionReference carts =
      FirebaseFirestore.instance.collection('carts');
  final CollectionReference products =
      FirebaseFirestore.instance.collection('products');

  Future<void> addToCart({
    required String userId,
    required String productId,
    required int quantity,
  }) async {
    DocumentReference userCartRef = carts.doc(userId);

    try {
      DocumentSnapshot cartSnapshot = await userCartRef.get();
      Map<String, dynamic>? cartData =
          cartSnapshot.data() as Map<String, dynamic>?;

      if (cartData == null) {
        await userCartRef.set({
          'products': [
            CartModel(productId: productId, quantity: quantity).toMap(),
          ],
        });
      } else {
        List<Map<String, dynamic>> products =
            List<Map<String, dynamic>>.from(cartData['products'] ?? []);

        int existingProductIndex =
            products.indexWhere((product) => product['productId'] == productId);

        if (existingProductIndex != -1) {
          // Update the quantity directly without calculation
          products[existingProductIndex]['quantity'] = quantity;
        } else {
          products
              .add(CartModel(productId: productId, quantity: quantity).toMap());
        }

        await userCartRef.update({'products': products});
      }
    } catch (error) {
      print('Error adding to cart: $error');
    }
  }

  Future<List<CartProduct>> getCartProducts({required String userId}) async {
    List<CartProduct> cartProducts = [];

    try {
      DocumentSnapshot cartSnapshot = await carts.doc(userId).get();

      if (cartSnapshot.exists) {
        Cart cart = Cart.fromFirestore(cartSnapshot);

        for (CartModel cartModel in cart.products) {
          String productId = cartModel.productId;

          try {
            DocumentSnapshot doc = await products.doc(productId).get();
            CartProduct product =
                CartProduct.fromMap(doc.data() as Map<String, dynamic>);

            cartProducts.add(product);
            print('cartProducts${cartProducts.length}');
          } catch (error) {
            print('Error fetching product data: $error');
          }
        }
      } else {
        print('Cart for user ID $userId does not exist.');
      }
    } catch (error) {
      print('Error getting cart data: $error');
    }

    return cartProducts;
  }

  Future<void> removeFromCart({
    required String userId,
    required String productId,
  }) async {
    try {
      // Get a reference to the user's cart
      DocumentReference<Map<String, dynamic>> userCartRef =
          carts.doc(userId) as DocumentReference<Map<String, dynamic>>;

      // Get the current contents of the user's cart
      DocumentSnapshot<Map<String, dynamic>> userCartSnapshot =
          await userCartRef.get();

      // Check if the cart exists and has products
      if (userCartSnapshot.exists &&
          userCartSnapshot.data() != null &&
          userCartSnapshot.data()!.containsKey('products')) {
        // Get the current list of products in the cart
        List<Map<String, dynamic>> products = List<Map<String, dynamic>>.from(
            userCartSnapshot.data()!['products']);

        // Remove the product with the specified productId
        products.removeWhere((product) => product['productId'] == productId);

        // Update the cart in Firestore with the modified products list
        await userCartRef.update({'products': products});

        print('Product $productId removed from the cart successfully');
      } else {
        print('User cart not found or has no products');
      }
    } catch (e) {
      print('Error removing product from cart: $e');
    }
  }
}
