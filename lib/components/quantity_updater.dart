import 'package:flutter/material.dart';

class QuantityUpdater extends StatefulWidget {
  final int initialQuantity;
  final ValueChanged<int>
      onQuantityChanged; // Callback for when quantity changes

  const QuantityUpdater({
    super.key,
    required this.initialQuantity,
    required this.onQuantityChanged,
  });

  @override
  State<QuantityUpdater> createState() => _QuantityUpdaterState();
}

class _QuantityUpdaterState extends State<QuantityUpdater> {
  late int
      quantity; // Initialize the quantity as late so it can be set via the constructor

  @override
  void initState() {
    super.initState();
    quantity =
        widget.initialQuantity; // Set the initial quantity from the constructor
  }

  void _increaseQuantity() {
    setState(() {
      quantity = quantity + 1;
    });
    widget.onQuantityChanged(
        quantity); // Notify the parent about the updated quantity
  }

  void _decreaseQuantity() {
    setState(() {
      if (quantity > 0) {
        quantity = quantity - 1;
      }
    });
    widget.onQuantityChanged(
        quantity); // Notify the parent about the updated quantity
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: _decreaseQuantity,
          icon: const Icon(Icons.remove),
        ),
        Text(quantity.toString()),
        IconButton(
          onPressed: _increaseQuantity,
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
