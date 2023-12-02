

// class QuantitySelector extends StatefulWidget {
//   // final int maxQuantity;
//   final ValueChanged<int> onSelectedQuantity;

//   const QuantitySelector({
//     super.key,
//     required this.onSelectedQuantity,
//   });

//   @override
//   _QuantitySelectorState createState() => _QuantitySelectorState();
// }

// class _QuantitySelectorState extends State<QuantitySelector> {
//   int currentQuantity = 1;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         IconButton(
//           icon: const Icon(Icons.remove),
//           onPressed: () {
//             if (currentQuantity > 1) {
//               setState(() {
//                 currentQuantity--;
//               });
//               widget.onSelectedQuantity(currentQuantity);
//             }
//           },
//         ),
//         Text('$currentQuantity'),
//         IconButton(
//           icon: const Icon(Icons.add),
//           onPressed: () {
//             if (currentQuantity < 10) {
//               setState(() {
//                 currentQuantity++;
//               });
//               widget.onSelectedQuantity(currentQuantity);
//             }
//           },
//         ),
//       ],
//     );
//   }
// }
