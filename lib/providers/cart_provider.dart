import 'package:flutter/material.dart';
import 'package:swipefit/components/cartpage_product_component.dart';

class CartProvider with ChangeNotifier {
  final List<CartpageProductComponent> _cartItems = [];

  List<CartpageProductComponent> get cartItems => _cartItems;

  void addItem(CartpageProductComponent item) {
    _cartItems.add(item);
    notifyListeners();
  }

  void removeItem(CartpageProductComponent item) {
    _cartItems.remove(item);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  // double calculateSubtotal() {
  //   // Assuming each `CartpageProductComponent` has a price property (make sure it’s added)
  //   return _cartItems.fold(0, (sum, item) => sum + item.price);
  // }
}
