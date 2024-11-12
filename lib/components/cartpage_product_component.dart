import 'package:flutter/material.dart';
import 'package:swipefit/components/quantity_updater.dart';
import 'package:swipefit/components/size_selector.dart';
import 'package:provider/provider.dart';
import 'package:swipefit/providers/cart_provider.dart';

class CartpageProductComponent extends StatelessWidget {
  final String productURL;
  final Widget? productImage;
  final String productCategory;
  final String productTitle;
  final double price;
  final int productId; // Unique product ID in Firestore
  final String userId; // User ID to identify the cart
  final VoidCallback? onRemove;
  String size = 'M'; // Default size value
  int quantity;

  CartpageProductComponent({
    required this.productURL,
    required this.quantity,
    required this.productId,
    required this.userId,
    this.productImage,
    required this.productCategory,
    required this.productTitle,
    required this.price,
    this.onRemove,
  });

  // Function to update size in the provider
  void _updateSize(BuildContext context, String newSize) {
    size = newSize;
    // Notify CartProvider about the size update
    Provider.of<CartProvider>(context, listen: false)
        .updateProductInCart(productId, newSize: newSize);
  }

  // Function to update quantity in the provider
  void _updateQuantity(BuildContext context, int newQuantity) {
    quantity = newQuantity;
    // Notify CartProvider about the quantity update
    Provider.of<CartProvider>(context, listen: false)
        .updateProductInCart(productId, newQuantity: newQuantity);
  }

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
                  Row(
                    children: [
                      const Text(
                        'Size:',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(width: 8),
                      SizeSelector(onSizeSelected: (newSize) {
                        _updateSize(context, newSize);
                      }),
                    ],
                  ),
                  const SizedBox(height: 8),
                  QuantityUpdater(
                    initialQuantity: quantity,
                    onQuantityChanged: (newQuantity) {
                      _updateQuantity(context, newQuantity);
                    },
                  ),
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

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': productTitle,
      'price': price,
      'quantity': quantity,
      'size': size,
      'imageUrl': productURL,
      'category': productCategory,
      'productId': productId, // Ensure productId is included
    };
  }

  // Create from JSON
  factory CartpageProductComponent.fromJson(Map<String, dynamic> json) {
    return CartpageProductComponent(
      quantity: json['quantity'],
      productURL: json['imageUrl'],
      productCategory: json['category'],
      productTitle: json['title'],
      price: json['price'],
      productId: json['productId'], // Ensure productId is used
      userId: json['userId'], // Ensure userId is passed if needed
    )..size = json['size'];
  }
}
