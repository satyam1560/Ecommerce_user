import 'package:flutter/material.dart';

class Quantity extends StatefulWidget {
  final ValueChanged<int> onQuantitySelected;

  const Quantity({Key? key, required this.onQuantitySelected})
      : super(key: key);

  @override
  State<Quantity> createState() => _QuantityState();
}

class _QuantityState extends State<Quantity> {
  int _currentQuantity = 1;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      value: _currentQuantity,
      icon: const Icon(Icons.keyboard_arrow_down),
      iconSize: 24,
      elevation: 16,
      underline: Container(), // This removes the underline
      onChanged: (int? newValue) {
        setState(() {
          _currentQuantity = newValue!;
        });
        widget.onQuantitySelected(
            _currentQuantity); // This calls the callback with the selected quantity
      },
      items: <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
          .map<DropdownMenuItem<int>>((int value) {
        return DropdownMenuItem<int>(
          value: value,
          child: Text('$value'),
        );
      }).toList(),
    );
  }
}
