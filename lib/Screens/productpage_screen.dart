import 'package:flutter/material.dart';
import 'package:swipefit/components/likedpage_product_component.dart';
import 'package:swipefit/components/quantity_updater.dart';
import 'package:swipefit/components/size_selector.dart';
import 'package:swipefit/handlers/payment_handler.dart';

class ProductPage extends StatefulWidget {
  final Widget imageWidget;
  final String title;
  final String description;
  final double rating;
  final double price;
  final String Category;

  const ProductPage({
    super.key,
    required this.imageWidget,
    required this.title,
    required this.description,
    required this.rating,
    required this.price,
    required this.Category,
  });

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool favorite = false;
  bool _isExpanded = false;
  late Widget _imageWidget;
  late String _title;
  late String _description;
  late int _rating;
  late double _price;
  late String _category;
  String _selectedSize = 'M'; // Store the selected size
  int _quantity = 1; // Store the selected quantity

  @override
  void initState() {
    super.initState();
    _imageWidget = widget.imageWidget;
    _title = widget.title;
    _description = widget.description;
    _rating = widget.rating.toInt();
    _price = widget.price;
    _category = widget.Category;
  }

  LikedpageProductComponent _buildLikedPageComponent() {
    return LikedpageProductComponent(
      price: _price,
      productCategory: _category,
      productImage: _imageWidget,
      productTitle: _title,
      rating: _rating,
    );
  }

  List<Widget> _buildStars() {
    List<Widget> stars = [];
    for (int i = 0; i < _rating; i++) {
      stars.add(const Icon(Icons.star, color: Colors.orange));
    }
    for (int j = _rating; j < 5; j++) {
      stars.add(const Icon(Icons.star_border, color: Colors.orange));
    }
    return stars;
  }

  // Function to handle size selection
  void _onSizeSelected(String size) {
    setState(() {
      _selectedSize = size; // Update the selected size
    });
  }

  // Function to handle quantity update
  void _onQuantityChanged(int newQuantity) {
    setState(() {
      _quantity = newQuantity; // Update the quantity
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.camera_alt, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: SizedBox(
                  height: MediaQuery.of(context).size.width * 0.6,
                  width: double.infinity,
                  child: _imageWidget,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                _title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  const SizedBox(width: 8),
                  Text(
                    'Rs.${_price.round()}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: _buildStars(),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        favorite = !favorite;
                        // Toggle favorite logic
                      });
                    },
                    icon: favorite
                        ? const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        : const Icon(
                            Icons.favorite_border,
                            color: Colors.red,
                          ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                "Size",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              SizeSelector(
                onSizeSelected: _onSizeSelected,
              ), // Pass the callback here
              const SizedBox(height: 16),
              const Text(
                "Description",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                _isExpanded
                    ? _description
                    : '${_description.substring(0, 50)}...', // Show partial text
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _isExpanded = !_isExpanded; // Toggle expanded state
                    });
                  },
                  child: Text(_isExpanded ? "Read less" : "Read more"),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text(
                    "Quantity:",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(width: 8),
                  QuantityUpdater(
                    initialQuantity: _quantity,
                    onQuantityChanged: _onQuantityChanged,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Add to cart logic here
                        // You can pass the selected size and quantity
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        "Add to cart",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        RazorpayService razorpayService =
                            RazorpayService(amount: _price.round());
                        razorpayService.openCheckout();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pinkAccent,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        "Buy now",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
