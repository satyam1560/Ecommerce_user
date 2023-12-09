//*   key_id-->     rzp_test_D3d8eyCiQVUMBd
//*   key_secret--> bT8VTOd7MrDEpjutc7toG7IC

// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';

// import '../../../../../../utils/constants/sizes.dart';
// import '../../data/repositories/razorpay_order_id.dart';

// class PaymentButton extends StatefulWidget {
//   final double? totalCheckoutPrice;
//   const PaymentButton({
//     super.key,
//     required this.totalCheckoutPrice,
//   });

//   @override
//   State<PaymentButton> createState() => _PaymentButtonState();
// }

// class _PaymentButtonState extends State<PaymentButton> {
//   final _razorpay = Razorpay();

//   @override
//   void initState() {
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//     super.initState();
//   }

//   void _handlePaymentSuccess(PaymentSuccessResponse response) {
//     print(
//         'orderId :${response.orderId} ,paymentId : ${response.paymentId}, signature:${response.signature}');

//     Fluttertoast.showToast(msg: response.paymentId!);
//   }

//   void _handlePaymentError(PaymentFailureResponse response) {
//     print(
//         'failure message: ${response.message}, error: ${response.error}, code: ${response.code}');
//   }

//   void _handleExternalWallet(ExternalWalletResponse response) {
//     print('External Wallet ${response.walletName}');
//   }

//   @override
//   void dispose() {
//     _razorpay.clear();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       style: ElevatedButton.styleFrom(
//         elevation: 10,
//         padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
//       ),
//       onPressed: () async {
//         //proceed to checkout---->page---->paynow
//         String orderId =
//             await OrderService().generateOrderId(widget.totalCheckoutPrice);
//         var options = {
//           'key': 'rzp_test_D3d8eyCiQVUMBd',
//           // 'amount': state.totalPrice! *
//           //     100,
//           'name': 'Acme Corp.',
//           'order_id': orderId,
//           // 'description': 'Fine T-Shirt',
//           'timeout': 90,
//           'prefill': {'contact': '7582924031', 'email': 'satyam.20ch@gmail.com'}
//         };
//         print('options: $options');
//         _razorpay.open(options);
//       },
//       child: const Text('Pay Now'),
//     );
//   }
// }
