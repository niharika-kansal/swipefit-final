import 'package:flutter/material.dart';
import 'package:swipefit/components/bottom_navbar.dart';

class LikedPage extends StatelessWidget {
  const LikedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Liked',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite, color: Colors.pink),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildLikedItem(
              context,
              imageUrl: 'https://example.com/dress1.jpg',
              title: 'Boucle Mini Dress-Ivory',
              brand: 'Meshki',
              price: 205,
              rating: 4.5,
            ),
            const SizedBox(height: 16),
            _buildLikedItem(
              context,
              imageUrl: 'https://example.com/dress2.jpg',
              title: 'Lilou Ivory Ruffle Dress',
              brand: 'House of CB',
              price: 255,
              rating: 4.8,
            ),
          ],
        ),
      ),
      bottomNavigationBar:BottomNavbar(currIdx: 2),
    );
  }

  Widget _buildLikedItem(
    BuildContext context, {
    required String imageUrl,
    required String title,
    required String brand,
    required double price,
    required double rating,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),

            // Product details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    brand,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$$price',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      // "Buy Now" button
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor
                          : Colors.pink[100],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                        ),
                        child: const Text(
                          'Buy now',
                          style: TextStyle(color: Colors.pink),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Rating stars
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        index < rating.round()
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.orange,
                        size: 20,
                      );
                    }),
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
