import 'dart:convert';
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
        print('Failed to load drinks: ${response.statusCode}');
        throw Exception('Failed to load drinks');
      }
    } catch (e) {
      print('Error fetching drinks: $e');
      throw Exception('Failed to load drinks');
    }
  }
}
