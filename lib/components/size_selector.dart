import 'package:flutter/material.dart';

class SizeSelector extends StatefulWidget {
  final Function(String) onSizeSelected;

  const SizeSelector({Key? key, required this.onSizeSelected})
      : super(key: key);

  @override
  State<SizeSelector> createState() => _SizeSelectorState();
}

class _SizeSelectorState extends State<SizeSelector> {
  String _selectedSize = 'M';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _selectedSize,
      items: <String>['S', 'M', 'L', 'XL'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _selectedSize = newValue ?? 'M';
        });
        widget.onSizeSelected(_selectedSize); // Notify parent of selected size
      },
      hint: const Text('Select a size'),
    );
  }
}
