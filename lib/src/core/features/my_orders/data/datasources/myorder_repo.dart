import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_user/src/core/features/my_orders/data/models/myorder_model.dart';

class MyOrderRepo {
  final orders = FirebaseFirestore.instance.collection('orders');

  Future<List<OrderModel>> getAllOrder({required String userID}) async {
    List<OrderModel> placedOrderList = [];
    var querySnapshot =
        await orders.doc(userID).collection('orderedProducts').get();
    for (var i in querySnapshot.docs) {
      placedOrderList.add(OrderModel.fromMap(i.data()['orderItem']));
      // print('DATA $placedOrderList');
    }
    return placedOrderList;
  }
}
