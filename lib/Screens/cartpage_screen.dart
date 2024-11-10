import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipefit/components/bottom_navbar.dart';
import 'package:swipefit/components/cartpage_product_component.dart';
import 'package:swipefit/providers/cart_provider.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Clear',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            Text(
              'My Cart',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Text(
              'FAQs',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Subtotal section
            Consumer<CartProvider>(
              builder: (context, cartProvider, child) {
                // final subtotal = cartProvider.calculateSubtotal();
                final subtotal = 200;
                return Text(
                  'Subtotal: \$${subtotal.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                );
              },
            ),
            const SizedBox(height: 16),

            // List of cart items
            Expanded(
              child: Consumer<CartProvider>(
                builder: (context, cartProvider, child) {
                  if (cartProvider.cartItems.isEmpty) {
                    return const Center(
                      child: Text("Your cart is empty"),
                    );
                  }
                  return ListView.builder(
                    itemCount: cartProvider.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartProvider.cartItems[index];
                      return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: item);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavbar(currIdx: 1),
    );
  }
}
