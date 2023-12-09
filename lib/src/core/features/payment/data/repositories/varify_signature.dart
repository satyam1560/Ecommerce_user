// import 'dart:convert';
// import 'package:crypto/crypto.dart';

// void verifySignature(String orderId='order_N9b1S8C5m8BVj0', String paymentId='pay_N9b1bX2vzBhELe', String signature, String secret = 'bT8VTOd7MrDEpjutc7toG7IC') {
//   var key = utf8.encode(secret);
//   var bytes = utf8.encode(orderId + "|" + paymentId);

//   var hmacSha256 = Hmac(sha256, key); // HMAC-SHA256
//   var digest = hmacSha256.convert(bytes);

//   print("Digest as bytes: ${digest.bytes}");
//   print("Digest as hex string: $digest");

//   if (digest.toString() == signature) {
//     print("Payment is successful");
//   } else {
//     print("Payment verification failed");
//   }
// }
