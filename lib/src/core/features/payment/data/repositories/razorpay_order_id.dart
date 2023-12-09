import 'dart:convert';

import 'package:http/http.dart' as http;

class OrderService {
  Future<String> generateOrderId(double? totalPrice) async {
    var orderOptions = {
      'amount': totalPrice! * 100, // amount in the smallest currency unit
      'currency': "INR",
      'receipt': "order_rcptid_11"
    };

    String basicAuth =
        'Basic ${base64Encode(utf8.encode('rzp_test_D3d8eyCiQVUMBd:bT8VTOd7MrDEpjutc7toG7IC'))}';

    final response = await http.post(
      Uri.parse('https://api.razorpay.com/v1/orders'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': basicAuth,
      },
      body: jsonEncode(orderOptions),
    );

    if (response.statusCode == 200) {
      final orderId = jsonDecode(response.body)['id'];
      return orderId;
    } else {
      throw Exception('Failed to create order.');
    }
  }
}
