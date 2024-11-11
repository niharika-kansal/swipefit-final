import 'package:flutter/material.dart';
import 'package:swipefit/components/likedpage_product_component.dart';

class LikeProvider with ChangeNotifier {
  final List<LikedpageProductComponent> _likedItems = [];

  List<LikedpageProductComponent> get likedItems => _likedItems;

  void addItem(LikedpageProductComponent item) {
    _likedItems.add(item);
    notifyListeners();
  }

  void removeItem(LikedpageProductComponent item) {
    _likedItems.remove(item);
    notifyListeners();
  }

  void clearList() {
    _likedItems.clear();
    notifyListeners();
  }

  // double calculateSubtotal() {
  //   // Assuming each `LikedpageProductComponent` has a price property (make sure it’s added)
  //   return _likedItems.fold(0, (sum, item) => sum + item.price);
  // }
}
