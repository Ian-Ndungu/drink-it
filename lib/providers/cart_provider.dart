import 'package:flutter/material.dart';
import '../models/drink.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _cart = [];

  List<CartItem> get cart => _cart;

  void addToCart(Drink drink) {
    final index = _cart.indexWhere((item) => item.drink.id == drink.id);

    if (index != -1) {
      _cart[index].quantity += 1;
    } else {
      _cart.add(CartItem(drink: drink, quantity: 1));
    }

    notifyListeners();
  }

  void removeFromCart(Drink drink) {
    final index = _cart.indexWhere((item) => item.drink.id == drink.id);

    if (index != -1) {
      if (_cart[index].quantity > 1) {
        _cart[index].quantity -= 1;
      } else {
        _cart.removeAt(index);
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  double getTotalPrice() {
    return _cart.fold(
      0.0,
      (sum, item) => sum + (item.drink.price * item.quantity),
    );
  }
}

class CartItem {
  final Drink drink;
  int quantity;

  CartItem({required this.drink, this.quantity = 1});
}
