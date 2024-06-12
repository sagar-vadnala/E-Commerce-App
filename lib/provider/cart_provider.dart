import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:e_commerce_app/models/product_model.dart';

class CartProvider with ChangeNotifier {
  final List<ProductModel> _cartItems = [];

  List<ProductModel> get cartItems => _cartItems;

  CartProvider() {
    _loadCartItems();
  }

  Future<void> _saveCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final cartItemsJson = _cartItems.map((item) => json.encode(item.toJson())).toList();
    await prefs.setStringList('cartItems', cartItemsJson);
  }

  Future<void> _loadCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final cartItemsJson = prefs.getStringList('cartItems');
    if (cartItemsJson != null) {
      _cartItems.addAll(cartItemsJson.map((itemJson) => ProductModel.fromJson(json.decode(itemJson))));
    }
    notifyListeners();
  }

void addToCart(ProductModel product) {
  // Check if the product already exists in the cart
  bool isDuplicate = _cartItems.any((item) => item.id == product.id);
  if (!isDuplicate) {
    _cartItems.add(product);
    _saveCartItems();
    notifyListeners();
  }
}


  void removeFromCart(ProductModel product) {
    _cartItems.remove(product);
    _saveCartItems();
    notifyListeners();
  }

  void clearCart() {
  _cartItems.clear();
  _saveCartItems();
  notifyListeners();
}

}


