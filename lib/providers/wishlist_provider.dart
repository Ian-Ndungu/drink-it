import 'package:flutter/material.dart';
import '../models/drink.dart';

class WishlistProvider with ChangeNotifier {
  final List<WishlistItem> _wishlist = [];

  List<WishlistItem> get wishlist => _wishlist;

  void addToWishlist(Drink drink) {
    final index = _wishlist.indexWhere((item) => item.drink.id == drink.id);

    if (index != -1) {
      _wishlist[index].quantity += 1;
    } else {
      _wishlist.add(WishlistItem(drink: drink, quantity: 1));
    }

    notifyListeners();
  }

  void removeFromWishlist(Drink drink) {
    final index = _wishlist.indexWhere((item) => item.drink.id == drink.id);

    if (index != -1) {
      if (_wishlist[index].quantity > 1) {
        _wishlist[index].quantity -= 1;
      } else {
        _wishlist.removeAt(index);
      }
      notifyListeners();
    }
  }
}

class WishlistItem {
  final Drink drink;
  int quantity;

  WishlistItem({required this.drink, this.quantity = 1});
}
