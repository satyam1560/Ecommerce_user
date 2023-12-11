//*   key_id-->     rzp_test_D3d8eyCiQVUMBd
//*   key_secret--> bT8VTOd7MrDEpjutc7toG7IC
import 'package:ecommerce_user/src/core/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:ecommerce_user/src/core/features/payment/presentation/widgets/text_fields.dart';
import 'package:ecommerce_user/utils/constants/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../cart/data/models/display_cart_model.dart';
import '../../../cart/data/models/proceed_checkout_model.dart';
import '../../../cart/data/repositories/proceed_checkout_repo.dart';
import '../../data/repositories/razorpay_order_id.dart';

class AddDeliveryDetails extends StatefulWidget {
  AddDeliveryDetails(
      {super.key,
      required this.totalCheckoutPrice,
      required this.productCart,
      required this.userId});
  final double? totalCheckoutPrice;
  List<DisplayCartModel>? productCart;
  String userId;

  @override
  State<AddDeliveryDetails> createState() => _AddDeliveryDetailsState();
}

class _AddDeliveryDetailsState extends State<AddDeliveryDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController fullAddressController = TextEditingController();

  final FormValidators _formValidators = FormValidators();
  final _razorpay = Razorpay();
  late String docID;

  late String fullName;
  late String email;
  late String phoneNo;
  late String fullAddress;
  void saveToDatabase() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (fullNameController.text.isEmpty ||
          emailController.text.isEmpty ||
          phoneNoController.text.isEmpty ||
          fullAddressController.text.isEmpty) {
        return;
      }

      fullName = fullNameController.text;
      email = emailController.text;
      phoneNo = phoneNoController.text;
      fullAddress = fullAddressController.text;

      proceedToPay();
      emailController.clear();
      fullNameController.clear();
      phoneNoController.clear();
      fullAddressController.clear();
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
      'prefill': {
        'contact': phoneNoController.text,
        'email': emailController.text
      }
    };
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
    ProceedToCheckoutRepo proceedToCheckoutRepo = ProceedToCheckoutRepo();

    List<Orders> ordersList = widget.productCart!
        .map((item) => Orders(
              userId: widget.userId,
              customerName: fullName,
              emailId: email,
              phoneno: int.parse(phoneNo),
              deliveryAddress: fullAddress,
              orderId: response.orderId,
              paymentId: response.paymentId,
              signature: response.signature,
              quantity: item.quantity as int,
              imageUrl: item.imageUrl,
              price: item.price as double,
              title: item.title,
            ))
        .toList();

    proceedToCheckoutRepo.enterOrderAndAddress(ordersList: ordersList);
    Fluttertoast.showToast(msg: 'PAYMENT SUCCESSFUL');
    BlocProvider.of<CartBloc>(context).add(EmptyCart(userId: widget.userId));
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
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            //enter name
            CustomFormField(
              textEditingController: fullNameController,
              hintText: 'Name',
              autofocus: true,
              icondata: const Icon(Icons.person),
            ),
            //enter email
            CustomFormField(
                textEditingController: emailController,
                hintText: 'Email Id',
                keyboardType: TextInputType.emailAddress,
                validator: (value) => _formValidators.validateEmail(value),
                autofocus: true,
                icondata: const Icon(Icons.email)),

            //enter phoneno
            CustomFormField(
                textEditingController: phoneNoController,
                hintText: 'Phone Number',
                keyboardType: TextInputType.number,
                validator: (value) =>
                    _formValidators.validatePhoneNumber(value),
                autofocus: true,
                icondata: const Icon(Icons.phone)),

            //full address
            CustomFormField(
              textEditingController: fullAddressController,
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
