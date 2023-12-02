// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CartModel extends Equatable {
  final String productId;
  final int quantity;
  CartModel? cartModel;

  CartModel({
    this.cartModel,
    required this.productId,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'quantity': quantity,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      productId: map['productId'],
      quantity: map['quantity'],
    );
  }

  @override
  List<Object?> get props => [productId, quantity, cartModel];
}

class Cart extends Equatable {
  final String userId;
  final List<CartModel> products;

  const Cart({
    required this.userId,
    required this.products,
  });

  factory Cart.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    List<Map<String, dynamic>> productsData =
        List<Map<String, dynamic>>.from(data['products']);

    List<CartModel> products = productsData
        .map((productData) => CartModel.fromMap(productData))
        .toList();

    return Cart(
      userId: doc.id,
      products: products,
    );
  }

  @override
  List<Object?> get props => [userId, products];
}


// class CartModel extends Equatable {
//   final String uid;
//   final String imgUrl;
//   final String title;
//   final num discountedPrice;
//   final int quantity;
//   const CartModel({
//     required this.uid,
//     required this.imgUrl,
//     required this.title,
//     required this.discountedPrice,
//     required this.quantity,
//   });

//   CartModel copyWith({
//     String? uid,
//     String? imgUrl,
//     String? title,
//     num? discountedPrice,
//     int? quantity,
//   }) {
//     return CartModel(
//       uid: uid ?? this.uid,
//       imgUrl: imgUrl ?? this.imgUrl,
//       title: title ?? this.title,
//       discountedPrice: discountedPrice ?? this.discountedPrice,
//       quantity: quantity ?? this.quantity,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'uid': uid,
//       'imgUrl': imgUrl,
//       'title': title,
//       'discountedPrice': discountedPrice,
//       'quantity': quantity,
//     };
//   }

//   factory CartModel.fromMap(Map<String, dynamic> map) {
//     return CartModel(
//       uid: map['uid'] as String,
//       imgUrl: map['imgUrl'] as String,
//       title: map['title'] as String,
//       discountedPrice: map['discountedPrice'] as num,
//       quantity: map['quantity'] as int,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory CartModel.fromJson(String source) =>
//       CartModel.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   bool get stringify => true;

//   @override
//   List<Object> get props {
//     return [
//       uid,
//       imgUrl,
//       title,
//       discountedPrice,
//       quantity,
//     ];
//   }
// }
