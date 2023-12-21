// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class AddToWishlistModel extends Equatable {
  final String? productId;
  final String? userId;
  final int? quantity;
  final String? imageUrl;
  final String? title;
  final double? price;
  const AddToWishlistModel({
    required this.productId,
    required this.userId,
    required this.quantity,
    this.imageUrl,
    this.title,
    this.price,
  });

  @override
  List<Object?> get props => [
        productId,
        userId,
        quantity,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': productId,
      'userId': userId,
      'quantity': quantity,
      'imageUrl': imageUrl,
      'title': title,
      'price': price,
    };
  }

  factory AddToWishlistModel.fromMap(Map<String, dynamic> map) {
    return AddToWishlistModel(
      productId: map['productId'] != null ? map['productId'] as String : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      price: map['price'] != null ? map['price'] as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddToWishlistModel.fromJson(String source) =>
      AddToWishlistModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
