import 'package:cloud_firestore/cloud_firestore.dart';

class ProceedToCheckoutRepo {
  final orders = FirebaseFirestore.instance.collection('orders');

  Future<String> enterDeliveryAddress(
      {required String userID,
      required String fullname,
      required String emailId,
      required String phoneNo,
      required String address}) async {
    var newDocRef = orders.doc(userID).collection('orderedProducts').doc();
    await newDocRef.set({
      'deliveryContactDetails': {
        'fullName': fullname,
        'emailId': emailId,
        'phoneNo': phoneNo,
        'address': address,
      },
    });
    return newDocRef.id;
  }

  void enterOrderItem(
      {required String userID,
      required String docID,
      required String signature,
      required String orderId,
      required String paymentId,
      required String imageUrl,
      required String title,
      required int price,
      required int quantity}) {
    orders.doc(userID).collection('orderedProducts').doc(docID).set({
      'orderItem': {
        'date': FieldValue.serverTimestamp(),
        'image': imageUrl,
        'signature': signature,
        'orderId': orderId,
        'paymentId': paymentId,
        'price': price,
        'quantity': quantity,
        'title': title,
      },
    }, SetOptions(merge: true));
  }

  Future<void> getAllDocIds(String userID) async {
    var querySnapshot =
        await orders.doc(userID).collection('orderedProducts').get();
    for (var doc in querySnapshot.docs) {
      print('----------------------------------------');
      print('Document ID: ${doc.id}');
      print('Document DATA: ${doc.data()}');
      print('----------------------------------------');
    }
  }
}
