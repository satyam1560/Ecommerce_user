import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/product_model.dart';

class ProductRepository {
  CollectionReference products =
      FirebaseFirestore.instance.collection('products');

  Future<List<Product>> getProducts() async {
    List<Product> productList = [];

    QuerySnapshot data = await products.get();
    print('querysnapshot-----${data.docs}');

    for (var doc in data.docs) {
      Product product = Product.fromMap(doc.data() as Map<String, dynamic>);
      // print('product********$product');
      String productId = doc.id;
      product.id = productId;
      productList.add(product);
    }
    print('productList-----$productList');

    return productList;
  }
}
