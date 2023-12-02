import 'dart:convert';

import 'package:equatable/equatable.dart';

class CartProduct extends Equatable {
  String? id;
  String? title;
  String? description;
  // num? productPrice;
  String? productImgUrl;
  int? productQuantity;
  num? sellingPrice;
  CartProduct({
    this.id,
    this.title,
    this.description,
    // this.productPrice,
    this.productImgUrl,
    this.productQuantity,
    this.sellingPrice,
  });

  CartProduct copyWith({
    String? id,
    String? title,
    String? description,
    // num? productPrice,
    String? productImgUrl,
    int? productQuantity,
    num? sellingPrice,
  }) {
    return CartProduct(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      // productPrice: productPrice ?? this.productPrice,
      productImgUrl: productImgUrl ?? this.productImgUrl,
      productQuantity: productQuantity ?? this.productQuantity,
      sellingPrice: sellingPrice ?? this.sellingPrice,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      // 'productPrice': productPrice,
      'productImgUrl': productImgUrl,
      'productQuantity': productQuantity,
      'sellingPrice': sellingPrice,
    };
  }

  factory CartProduct.fromMap(Map<String, dynamic> map) {
    return CartProduct(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      // productPrice: map['productPrice'] ?? '',
      productImgUrl: map['productImgUrl'] ?? '',
      productQuantity: map['productQuantity'] ?? '0',
      sellingPrice: map['sellingPrice'] ?? 0,
    );
  }
  String toJson() => json.encode(toMap());

  factory CartProduct.fromJson(String source) =>
      CartProduct.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
  @override
  List<Object?> get props => [
        id,
        title,
        description,
        // productPrice,
        productImgUrl,
        productQuantity,
        sellingPrice
      ];
}
