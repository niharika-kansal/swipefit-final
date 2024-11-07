import 'package:flutter/material.dart';
import 'package:appinio_swiper/appinio_swiper.dart';

class ImageSwiper extends StatefulWidget {
  @override
  _ImageSwiperState createState() => _ImageSwiperState();
}

class _ImageSwiperState extends State<ImageSwiper> {
  final int _imageCount = 7;
  Key _swiperKey = UniqueKey();

  void _resetSwiper() {
    // This function resets the swiper by regenerating a new unique key
    setState(() {
      _swiperKey = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppinioSwiper(
      key: _swiperKey, // Assign the unique key to the swiper
      onSwipeBegin: (previousIndex, targetIndex, activity) {
        print("Swiping from image${previousIndex + 1} to image${targetIndex + 1}");
      },
      cardBuilder: (BuildContext context, int index) {
        // Dynamically load images based on the index
        String imageName = './assets/images/image${index + 1}.jpg';
        return Container(
          alignment: Alignment.center,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              imageName,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        );
      },
      cardCount: _imageCount,
      swipeOptions: SwipeOptions.only(up: true, right: true, left: true),
      onEnd: () {
        // Reset the swiper to start from the first image
        _resetSwiper();
      },
    );
  }
}
