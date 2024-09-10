// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Drink model
class Drink {
  final String id;
  final String name;
  final double price;

  Drink({required this.id, required this.name, required this.price});

  // Convert a Drink instance to a map
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'price': price,
      };

  // Create a Drink instance from a map
  factory Drink.fromJson(Map<String, dynamic> json) {
    return Drink(
      id: json['id'],
      name: json['name'],
      price: json['price'],
    );
  }
}

// Order model
class Order {
  final int id;
  String status;

  Order({required this.id, required this.status});
}

// User model
class User {
  final String email;
  String role;
  final String imageUrl;

  User({
    required this.email,
    required this.role,
    required this.imageUrl,
  });
}

class AdminProvider with ChangeNotifier {
  // Private lists to manage state
  final List<Drink> _drinks = [];
  final List<Order> _orders = [];
  List<User> _users = [];

  // Public getters for accessing lists
  List<Drink> get drinks => _drinks;
  List<Order> get orders => _orders;
  List<User> get users => _users;

  AdminProvider() {
_users = [
  User(email: 'iannjagah@gmail.com', role: 'Admin', imageUrl: 'assets/images/user1.jpg'),
  User(email: 'finnesskelvin@gmail.com', role: 'User', imageUrl: 'assets/images/user2.jpg'),
  User(email: 'jobkimari@gmail.com', role: 'User', imageUrl: 'assets/images/user3.jpg'),
];
  }

  // Methods for managing drinks
  void addDrink(Drink drink) {
    _drinks.add(drink);
    notifyListeners();
  }

  void deleteDrink(Drink drink) {
    _drinks.remove(drink);
    notifyListeners();
  }

  void updateDrink(Drink drink) {
    int index = _drinks.indexWhere((d) => d.id == drink.id);
    if (index != -1) {
      _drinks[index] = drink;
      notifyListeners();
    }
  }

  // Method to fetch drinks from an API
  Future<void> fetchDrinks() async {
    const url = 'https://https://drink-api-1.onrender.com/api/drinks'; 

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _drinks.clear();
        _drinks.addAll(data.map((json) => Drink.fromJson(json)).toList());
        notifyListeners();
      } else {
        throw Exception('Failed to load drinks');
      }
    } catch (e) {
      print('Error fetching drinks: $e');
      // Optionally, handle the error (e.g., show a snackbar or dialog)
    }
  }

  // Methods for managing orders
  void addOrder(Order order) {
    _orders.add(order);
    notifyListeners();
  }

  void updateOrderStatus(int orderId, String newStatus) {
    int index = _orders.indexWhere((o) => o.id == orderId);
    if (index != -1) {
      _orders[index].status = newStatus;
      notifyListeners();
    }
  }

  void deleteOrder(Order order) {
    _orders.remove(order);
    notifyListeners();
  }

  // Methods for managing users
  void addUser(User user) {
    _users.add(user);
    notifyListeners();
  }

  void updateUserRole(String email, String newRole) {
    int index = _users.indexWhere((u) => u.email == email);
    if (index != -1) {
      _users[index].role = newRole;
      notifyListeners();
    }
  }

  void deleteUser(User user) {
    _users.remove(user);
    notifyListeners();
  }
}
