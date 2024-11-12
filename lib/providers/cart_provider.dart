import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:swipefit/components/cartpage_product_component.dart';

class CartProvider with ChangeNotifier {
  final List<CartpageProductComponent> _cartItems = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<CartpageProductComponent> get cartItems => _cartItems;

  // Get the current user ID
  String? get userId => _auth.currentUser?.uid;

  // Method to save the current cart to Firebase
  Future<void> saveCartToFirebase() async {
    if (userId == null) return;

    final userCartRef = _firestore.collection('cart').doc(userId);

    // Convert `CartpageProductComponent` items to a JSON format
    final cartItemsData = _cartItems.map((item) => item.toJson()).toList();

    await userCartRef.set({
      'cartItems': cartItemsData,
    });
  }

  // Add item to cart
  void addItem(CartpageProductComponent item) {
    _cartItems.add(item);
    notifyListeners();
    saveCartToFirebase();
  }

  // Remove item from cart
  void removeItem(CartpageProductComponent item) {
    _cartItems.remove(item);
    notifyListeners();
    saveCartToFirebase();
  }

  // Clear cart
  void clearCart() {
    _cartItems.clear();
    notifyListeners();
    saveCartToFirebase();
  }

  // Load cart from Firebase
  Future<void> loadCartFromFirebase() async {
    if (userId == null) return;

    final userCartRef = _firestore.collection('cart').doc(userId);
    final docSnapshot = await userCartRef.get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data();
      if (data != null && data['cartItems'] != null) {
        _cartItems.clear();
        // Convert JSON to CartpageProductComponent instances
        data['cartItems'].forEach((itemData) {
          _cartItems.add(CartpageProductComponent.fromJson(itemData));
        });
        notifyListeners();
      }
    }
  }

  // Update the size and quantity of a product in the cart
  void updateProductInCart(int productId, {String? newSize, int? newQuantity}) {
    final productIndex =
        _cartItems.indexWhere((item) => item.productId == productId);
    if (productIndex != -1) {
      final product = _cartItems[productIndex];
      if (newSize != null) product.size = newSize;
      if (newQuantity != null) product.quantity = newQuantity;

      // Save changes to Firebase
      saveCartToFirebase();
      notifyListeners();
    }
  }
}
