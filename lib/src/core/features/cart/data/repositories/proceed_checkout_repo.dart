import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/proceed_checkout_model.dart';

class ProceedToCheckoutRepo {
  final orders = FirebaseFirestore.instance.collection('orders');

  // void enterOrderAndAddress({
  //   required String userId,
  //   required String customerName,
  //   required String emailId,
  //   required int phoneno,
  //   required String deliveryAddress,
  //   required String orderId,
  //   required String paymentId,
  //   required String signature,
  //   required int quantity,
  //   required String imageUrl,
  //   required double price,
  //   required String title,
  // }) {
  //   orders.doc(userId).collection('orderedProducts').doc().set({
  //     'deliveryContactDetails': {
  //       'fullName': customerName,
  //       'emailId': emailId,
  //       'phoneNo': phoneno,
  //       'address': deliveryAddress,
  //     },
  //     'orderItem': {
  //       'date': FieldValue.serverTimestamp(),
  //       'signature': signature,
  //       'orderId': orderId,
  //       'paymentId': paymentId,
  //       'quantity': quantity,
  //       'imageUrl': imageUrl,
  //       'price': price,
  //       'title': title,
  //     },
  //   });
  // }
  void enterOrderAndAddress({required List<Orders> ordersList}) {
    WriteBatch batch = FirebaseFirestore.instance.batch();

    for (Orders order in ordersList) {
      DocumentReference docRef =
          orders.doc(order.userId).collection('orderedProducts').doc();
      batch.set(docRef, {
        'deliveryContactDetails': {
          'fullName': order.customerName,
          'emailId': order.emailId,
          'phoneNo': order.phoneno,
          'address': order.deliveryAddress,
        },
        'orderItem': order.toMap(),
      });
    }

    batch.commit();
  }

//! below one has to be implemented in my order page
}
