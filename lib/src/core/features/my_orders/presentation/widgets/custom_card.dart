import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomCard extends StatelessWidget {
  final String orderId;
  final String title;
  final String imageUrl;
  final double price;
  final int quantity;
  final DateTime orderDate;

  const CustomCard({
    super.key,
    required this.orderId,
    required this.title,
    required this.price,
    required this.quantity,
    required this.orderDate,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    DateFormat formatter = DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(orderDate);
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                width: 100,
                height: 100,
                color: Colors.purple,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'ID: $orderId',
                style: const TextStyle(
                    color: Colors.orange, fontWeight: FontWeight.w500),
              ),
              Text(
                'Title: $title',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Text('Price: $price'),
              Text('Qty: $quantity'),
              Text(
                'Order Date: $formattedDate',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
