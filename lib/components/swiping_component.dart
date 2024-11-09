import 'package:flutter/material.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';

class ImageSwiper extends StatefulWidget {
  final Map response;
  const ImageSwiper({super.key, required this.response});

  @override
  _ImageSwiperState createState() => _ImageSwiperState();
}

class _ImageSwiperState extends State<ImageSwiper> {
  late List _products;
  Key _swiperKey = UniqueKey();
  late MatchEngine _matchEngine;
  final List<SwipeItem> _swipeItems = [];

  void _populateSwipeItems() {
    _swipeItems.clear();

    for (int i = 0; i < _products.length; i++) {
      final product = _products[i];
      final imageUrl = product['images'][0];
      final title = product['title'];
      final price = product['price'];

      _swipeItems.add(SwipeItem(
        content: Stack(
          children: [
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Icon(Icons.error, color: Colors.red),
                );
              },
            ),
            Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFFF84B8).withOpacity(0.8),
                      Colors.black.withOpacity(0.7),
                    ],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$title - \$$price',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        likeAction: () {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Liked $title"),
            duration: const Duration(milliseconds: 500),
          ));
        },
        nopeAction: () {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Nope $title"),
            duration: const Duration(milliseconds: 500),
          ));
        },
        superlikeAction: () {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Added to cart $title"),
            duration: const Duration(milliseconds: 500),
          ));
        },
        onSlideUpdate: (SlideRegion? region) async {
          print("Region $region");
          return Future.value();
        },
      ));
    }
  }

  void _resetSwiper() {
    setState(() {
      _populateSwipeItems();
      _matchEngine = MatchEngine(swipeItems: _swipeItems);
      _swiperKey = UniqueKey();
    });
  }

  @override
  void initState() {
    super.initState();
    _products = widget.response['products'];
    _populateSwipeItems();
    _matchEngine = MatchEngine(swipeItems: _swipeItems);
  }

  @override
  Widget build(BuildContext context) {
    return SwipeCards(
      key: _swiperKey,
      matchEngine: _matchEngine,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: _swipeItems[index].content,
        );
      },
      onStackFinished: () {
        _resetSwiper();
      },
      itemChanged: (SwipeItem item, int index) {},
      upSwipeAllowed: true,
      fillSpace: true,
    );
  }
}
