// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class DisplayCartModel extends Equatable {
  final String? productId;
  final num? quantity;
  final String? title;
  final num? price;
  final String? imageUrl;
  final String? userId;
  const DisplayCartModel({
    required this.productId,
    required this.quantity,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.userId,
  });

  @override
  List<Object?> get props => [
        productId,
        quantity,
        title,
        price,
        imageUrl,
        userId,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': productId,
      'quantity': quantity,
      'title': title,
      'price': price,
      'imageUrl': imageUrl,
      'userId': userId,
    };
  }

  factory DisplayCartModel.fromMap(Map<String, dynamic> map) {
    return DisplayCartModel(
      productId: map['productId'] as String,
      quantity: map['quantity'] as num,
      title: map['title'] as String,
      price: map['price'] as num,
      imageUrl: map['imageUrl'] as String,
      userId: map['userId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DisplayCartModel.fromJson(String source) =>
      DisplayCartModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
