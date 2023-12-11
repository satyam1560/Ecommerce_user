// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class AddToCartModel extends Equatable {
  final String? productId;
  final String? userId;
  final int? quantity;
  const AddToCartModel({
    required this.productId,
    required this.userId,
    required this.quantity,
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
      'quantity': quantity,
    };
  }

  factory AddToCartModel.fromMap(Map<String, dynamic> map) {
    return AddToCartModel(
      productId: map['productId'] as String,
      userId: map['userId'] as String,
      quantity: map['quantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddToCartModel.fromJson(String source) =>
      AddToCartModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
