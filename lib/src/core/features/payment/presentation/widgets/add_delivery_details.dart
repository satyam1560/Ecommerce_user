//*   key_id-->     rzp_test_D3d8eyCiQVUMBd
//*   key_secret--> bT8VTOd7MrDEpjutc7toG7IC
import 'package:ecommerce_user/src/core/features/payment/presentation/widgets/text_fields.dart';
import 'package:ecommerce_user/utils/constants/validators.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../cart/data/models/display_cart_model.dart';
import '../../../cart/data/repositories/proceed_checkout_repo.dart';
import '../../data/repositories/razorpay_order_id.dart';

class AddDeliveryDetails extends StatefulWidget {
  AddDeliveryDetails(
      {super.key,
      required this.totalCheckoutPrice,
      required this.productCart,
      required this.userId});
  final double? totalCheckoutPrice;
  List<DisplayCartModel> productCart;
  String userId;

  @override
  State<AddDeliveryDetails> createState() => _AddDeliveryDetailsState();
}

class _AddDeliveryDetailsState extends State<AddDeliveryDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController fullName = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController phoneNo = TextEditingController();

  TextEditingController fullAddress = TextEditingController();

  final FormValidators _formValidators = FormValidators();

  final _razorpay = Razorpay();
  late String docID;

  ProceedToCheckoutRepo repo = ProceedToCheckoutRepo();
  void saveToDatabase() async {
    if (_formKey.currentState?.validate() ?? false) {
      String userID = widget.userId;

      // Call enterDeliveryAddress and get the document ID
      docID = await repo.enterDeliveryAddress(
        userID: userID,
        fullname: fullName.text,
        emailId: email.text,
        phoneNo: phoneNo.text,
        address: fullAddress.text,
      );
      print('Full Name: ${fullName.text}');
      print('Email: ${email.text}');
      print('Phone No: ${phoneNo.text}');
      print('Full Address: ${fullAddress.text}');
      proceedToPay();
    }
  }

  void proceedToPay() async {
    String orderId =
        await OrderService().generateOrderId(widget.totalCheckoutPrice);
    var options = {
      'key': 'rzp_test_D3d8eyCiQVUMBd',
      'name': 'Acme Corp.',
      'order_id': orderId,
      'timeout': 90,
      'prefill': {'contact': phoneNo.text, 'email': email.text}
    };
    print('options: $options');
    _razorpay.open(options);
  }

  @override
  void initState() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print(
        'orderId :${response.orderId} ,paymentId : ${response.paymentId}, signature:${response.signature}');
    repo.enterOrderItem(
      userID: widget.userId,
      docID: docID,
      signature: response.signature!,
      orderId: response.orderId!,
      paymentId: response.paymentId!,
      imageUrl: 'imageUrl',
      title: 'title',
      price: 10,
      quantity: 5,
    );
    Fluttertoast.showToast(msg: response.paymentId!);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print(
        'failure message: ${response.message}, error: ${response.error}, code: ${response.code}');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External Wallet ${response.walletName}');
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          children: [
            //enter name
            CustomFormField(
              textEditingController: fullName,
              hintText: 'Name',
              autofocus: true,
              icondata: const Icon(Icons.person),
            ),
            //enter email
            CustomFormField(
                textEditingController: email,
                hintText: 'Email Id',
                keyboardType: TextInputType.emailAddress,
                validator: (value) => _formValidators.validateEmail(value),
                autofocus: true,
                icondata: const Icon(Icons.email)),

            //enter phoneno
            CustomFormField(
                textEditingController: phoneNo,
                hintText: 'Phone Number',
                keyboardType: TextInputType.number,
                validator: (value) =>
                    _formValidators.validatePhoneNumber(value),
                autofocus: true,
                icondata: const Icon(Icons.phone)),

            //full address
            CustomFormField(
              textEditingController: fullAddress,
              maxlines: 3,
              hintText: 'Full Delivery address',
              autofocus: true,
            ),
            OutlinedButton(
                onPressed: () {
                  saveToDatabase();
                },
                child: const Text('Pay Now'))
          ],
        ),
      ),
    );
  }
}
