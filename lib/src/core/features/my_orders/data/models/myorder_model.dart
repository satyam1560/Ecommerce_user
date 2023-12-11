// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class MyOrderModel {
  Timestamp date;
  String orderId;
  List<OrderList> orderList;
  MyOrderModel({
    required this.date,
    required this.orderId,
    required this.orderList,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date.millisecondsSinceEpoch,
      'orderId': orderId,
      'orderList': orderList.map((x) => x.toMap()).toList(),
    };
  }

  factory MyOrderModel.fromMap(Map<String, dynamic> map) {
    return MyOrderModel(
      date: map['date'] as Timestamp,
      orderId: map['orderId'] as String,
      orderList: List<OrderList>.from(
        (map['orderList'] as List<dynamic>).map<OrderList>(
          (x) => OrderList.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory MyOrderModel.fromJson(String source) =>
      MyOrderModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class OrderList {
  String image;
  double price;
  int quantity;
  String title;
  OrderList({
    required this.image,
    required this.price,
    required this.quantity,
    required this.title,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image': image,
      'price': price,
      'quantity': quantity,
      'title': title,
    };
  }

  factory OrderList.fromMap(Map<String, dynamic> map) {
    return OrderList(
      image: map['image'] as String,
      price: map['price'] as double,
      quantity: map['quantity'] as int,
      title: map['title'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderList.fromJson(String source) =>
      OrderList.fromMap(json.decode(source) as Map<String, dynamic>);
}
