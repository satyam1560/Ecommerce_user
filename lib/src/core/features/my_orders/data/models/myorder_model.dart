// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart' as firebase;

class OrderModel {
  String orderId;
  int quantity;
  double price;
  String imageUrl;
  String title;
  DateTime date;

  OrderModel({
    required this.orderId,
    required this.quantity,
    required this.imageUrl,
    required this.price,
    required this.title,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderId': orderId,
      'quantity': quantity,
      'price': price,
      'imageUrl': imageUrl,
      'title': title,
      'date': date,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    var timestamp = map['date'] as firebase.Timestamp;
    return OrderModel(
      orderId: map['orderId'] as String,
      quantity: map['quantity'] as int,
      price: map['price'] as double,
      imageUrl: map['imageUrl'] as String,
      title: map['title'] as String,
      date: timestamp.toDate(),
    );
  }
  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
