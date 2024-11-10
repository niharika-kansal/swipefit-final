import 'package:flutter/material.dart';
import 'package:swipefit/components/quantity_updater.dart';
import 'package:swipefit/components/size_selector.dart';
import 'package:swipefit/handlers/payment_handler.dart';

class ProductPage extends StatefulWidget {
  final Widget imageWidget;
  final String title;
  final String description;
  final double rating;
  final double price;

  ProductPage({
    super.key,
    required this.imageWidget,
    required this.title,
    required this.description,
    required this.rating,
    required this.price,
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

  @override
  void initState() {
    super.initState();
    _imageWidget = widget.imageWidget;
    _title = widget.title;
    _description = widget.description;
    _rating = widget.rating.toInt();
    _price = widget.price;
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
                child: Container(
                  child: _imageWidget,
                  height: MediaQuery.of(context).size.width * 0.6,
                  width: double.infinity,
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
                    'Rs.$_price',
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
              const SizeSelector(),
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
              const Row(
                children: [
                  Text(
                    "Quantity:",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(width: 8),
                  QuantityUpdater()
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
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
                        RazorpayService razorpayService = RazorpayService();
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
