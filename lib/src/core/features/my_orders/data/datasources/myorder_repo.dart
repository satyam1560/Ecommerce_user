import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/myorder_model.dart';

class MyOrderRepo {
  final orders = FirebaseFirestore.instance.collection('orders');

  Future<List<MyOrderModel>> getAllOrders({required String userID}) async {
    var querySnapshot =
        await orders.doc(userID).collection('orderedProducts').get();
    List<MyOrderModel> orderModels = [];
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data();
      orderModels.add(MyOrderModel.fromMap(data["orderItem"]));
    }
    // for (MyOrderModel orderModel in orderModels) {
    //   print('----------------------------------------');
    //   print('Order ID: ${orderModel.orderId}');
    //   print('Date: ${orderModel.date}');
    //   for (OrderList orderList in orderModel.orderList) {
    //     print('Image URL: ${orderList.image}');
    //     print('Title: ${orderList.title}');
    //     print('Price: ${orderList.price}');
    //     print('Price: ${orderList.quantity}');
    //   }
    //   print('----------------------------------------');
    // }

    // print('orderModels $orderModels');
    return orderModels;
  }
}
