import 'package:flutter/material.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';

class ImageSwiper extends StatefulWidget {
  @override
  _ImageSwiperState createState() => _ImageSwiperState();
}

class _ImageSwiperState extends State<ImageSwiper> {
  final int _imageCount = 7;
  Key _swiperKey = UniqueKey();
  late MatchEngine _matchEngine;
  List<SwipeItem> _swipeItems = [];

  void _populateSwipeItems() {
    // Populate _swipeItems with images from 1 to 7
    for (int i = 1; i <= _imageCount; i++) {
      _swipeItems.add(SwipeItem(
        content: Image.asset(
          'assets/images/image$i.jpg',
          fit: BoxFit.cover,
        ),
        likeAction: () {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("yayy product $i"),
            duration: Duration(milliseconds: 500),
          ));
        },
        nopeAction: () {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("nope product $i"),
            duration: Duration(milliseconds: 500),
          ));
        },
        superlikeAction: () {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("added to cart product $i"),
            duration: Duration(milliseconds: 500),
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
      _swipeItems.clear(); // Clear the current items
      _populateSwipeItems(); // Repopulate the items
      _matchEngine = MatchEngine(swipeItems: _swipeItems); // Reset MatchEngine
      _swiperKey = UniqueKey(); // Update the swiper key
    });
  }

  @override
  void initState() {
    super.initState();
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
          child: _swipeItems[index]
              .content, // Display the image from the content of SwipeItem
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
