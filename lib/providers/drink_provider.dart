import 'package:flutter/material.dart';
import 'package:drinkit/services/api_service.dart';
import 'package:drinkit/models/drink.dart';

class DrinkProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Drink> _drinks = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Drink> get drinks => _drinks;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchDrinks() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _drinks = await _apiService.fetchDrinks();
    } catch (e) {
      _errorMessage = 'Failed to load drinks';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
