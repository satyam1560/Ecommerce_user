import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/my_orders_bloc.dart';
// Import the file where MyOrdersBloc is defined

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({Key? key}) : super(key: key);

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  @override
  void initState() {
    super.initState();

    // Trigger the event when the screen is built
    BlocProvider.of<MyOrdersBloc>(context).add(
      const PurchasedItems(userId: 'F9oehnrO8CYotAI2RhEuUyNASp33'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Orders'),
          centerTitle: true,
        ),
        body: BlocBuilder<MyOrdersBloc, MyOrderState>(
          builder: (context, state) {
            if (state.myOrderStatus == MyOrderStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.myOrderStatus == MyOrderStatus.success) {
              final myOrder = state.myOrder;
              return ListView.builder(
                itemCount: myOrder!.length,
                itemBuilder: (context, index) {
                  var order = myOrder[index];
                  return ListTile(
                    title: Text(order.orderId),
                  );
                },
              );
            }
            return Container();
          },
        ) // Replace with the actual widget you want to display
        );
  }
}
