import 'package:flutter/material.dart';
import 'package:swipefit/components/quantity_updater.dart';
import 'package:swipefit/components/size_selector.dart';

class CartpageProductComponent extends StatelessWidget {
  final Widget productImage;
  final String productCategory;
  final String productTitle;
  final double price;
  final VoidCallback? onRemove;

  const CartpageProductComponent({
    super.key,
    required this.productImage,
    required this.productCategory,
    required this.productTitle,
    required this.price,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: SizedBox(
                width: 80,
                height: 80,
                child: productImage,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productTitle,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    productCategory,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Text('Price: Rs.${price.round()}'),
                  const Row(
                    children: [
                      Text(
                        'Size:',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(width: 8),
                      SizeSelector()
                    ],
                  ),
                  const SizedBox(height: 8),
                  const QuantityUpdater(),
                  if (onRemove != null) // Only show remove button if provided
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: onRemove,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
