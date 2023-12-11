import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'display_cart_model.dart';

// Model class for Orders
class Orders extends Equatable {
  final String? userId;
  final String? customerName;
  final String? emailId;
  final int? phoneno;
  final String? deliveryAddress;
  final String? orderId;
  final String? paymentId;
  final String? signature;
  final int? quantity;
  final String? imageUrl;
  final double? price;
  final String? title;

  const Orders({
    required this.userId,
    required this.customerName,
    required this.emailId,
    required this.phoneno,
    required this.deliveryAddress,
    required this.orderId,
    required this.paymentId,
    required this.signature,
    required this.quantity,
    required this.imageUrl,
    required this.price,
    required this.title,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': FieldValue.serverTimestamp(),
      'orderId': orderId,
      'paymentId': paymentId,
      'signature': signature,
      'quantity': quantity,
      'imageUrl': imageUrl,
      'price': price,
      'title': title,
    };
  }

  static Orders fromMap(Map<String, dynamic> map) {
    return Orders(
      userId: map['userId'],
      customerName: map['customerName'],
      emailId: map['emailId'],
      phoneno: map['phoneno'],
      deliveryAddress: map['deliveryAddress'],
      orderId: map['orderId'],
      paymentId: map['paymentId'],
      signature: map['signature'],
      quantity: map['quantity'],
      imageUrl: map['imageUrl'],
      price: map['price'],
      title: map['title'],
    );
  }

  @override
  List<Object?> get props => [
        userId,
        customerName,
        emailId,
        phoneno,
        deliveryAddress,
        orderId,
        paymentId,
        signature,
        quantity,
        imageUrl,
        price,
        title,
      ];

  Orders.fromDisplayCartModel(
    DisplayCartModel model,
    this.userId,
    this.customerName,
    this.emailId,
    this.phoneno,
    this.deliveryAddress,
    this.orderId,
    this.paymentId,
    this.signature,
  )   : quantity = model.quantity as int,
        imageUrl = model.imageUrl,
        price = model.price as double,
        title = model.title;
}
