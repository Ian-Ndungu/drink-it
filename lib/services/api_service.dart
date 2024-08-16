import 'dart:convert';
import 'package:drinkit/providers/cart_provider.dart';
// ignore: implementation_imports
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:http/http.dart' as http;
import 'package:drinkit/models/drink.dart';

class ApiService {
  final String baseUrl = 'https://drink-api-1.onrender.com/api';

  Future<List<Drink>> fetchDrinks() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/drinks'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        return jsonData.map((drink) => Drink.fromJson(drink)).toList();
      } else {
        throw Exception('Failed to load drinks');
      }
    } catch (e) {
      throw Exception('Failed to load drinks');
    }
  }

  processOrder(List<CartItem> cart, String phoneNumber, LatLng? pickedLatLng) {}

 Future<Map<String, List<Drink>>> fetchDrinksByCategory() async {
    final response = await http.get(Uri.parse('$baseUrl/drinks_by_category'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final Map<String, List<Drink>> drinksByCategory = {};

      for (var category in data.keys) {
        final List<dynamic> drinksJson = data[category];
        final List<Drink> drinks = drinksJson.map((json) => Drink.fromJson(json)).toList();
        drinksByCategory[category] = drinks;
      }

      return drinksByCategory;
    } else {
      throw Exception('Failed to load drinks by category');
    }
  }

}

