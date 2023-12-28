import 'dart:convert';

import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String? id;
  final String? title;
  final String? productImgUrl;
  final int? productQuantity;
  final num? sellingPrice;
  const Product({
    this.id,
    this.title,
    this.productImgUrl,
    this.productQuantity,
    this.sellingPrice,
  });

  Product copyWith({
    String? id,
    String? title,
    String? productImgUrl,
    int? productQuantity,
    num? sellingPrice,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      productImgUrl: productImgUrl ?? this.productImgUrl,
      productQuantity: productQuantity ?? this.productQuantity,
      sellingPrice: sellingPrice ?? this.sellingPrice,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'productImgUrl': productImgUrl,
      'productQuantity': productQuantity,
      'sellingPrice': sellingPrice,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      productImgUrl: map['productImgUrl'] ?? '',
      productQuantity: map['productQuantity'] ?? '0',
      sellingPrice: map['sellingPrice'] ?? 0,
    );
  }
  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
  @override
  List<Object?> get props =>
      [id, title, productImgUrl, productQuantity, sellingPrice];
}
