// ignore_for_file: library_private_types_in_public_api, no_leading_underscores_for_local_identifiers, use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:drinkit/models/drink.dart' as drink_model;
import 'package:drinkit/services/api_service.dart';

class AddDrinkPage extends StatefulWidget {
  const AddDrinkPage({super.key});

  @override
  _AddDrinkPageState createState() => _AddDrinkPageState();
}

class _AddDrinkPageState extends State<AddDrinkPage> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _categoryController = TextEditingController();
  final ApiService _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    // Method to add a drink using the API service
    void _addDrink() {
      final name = _nameController.text;
      final price = double.tryParse(_priceController.text) ?? 0.0;
      final imageUrl = _imageUrlController.text;
      final category = _categoryController.text;

      if (name.isNotEmpty && price > 0) {
        final drink = drink_model.Drink(
          id: DateTime.now().millisecondsSinceEpoch, // A temporary id
          name: name,
          price: price,
          image_url: imageUrl,
          category: category,
        );

        // Call the API service to add the drink
        _apiService.addDrink(drink).then((_) {
          Navigator.of(context).pop(); // Close the page after success
        }).catchError((error) {
          // Handle error (you can show a Snackbar or a Dialog)
          print('Failed to add drink: $error');
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Drink'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _imageUrlController,
              decoration: const InputDecoration(labelText: 'Image URL'),
            ),
            TextField(
              controller: _categoryController,
              decoration: const InputDecoration(labelText: 'Category'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addDrink,
              child: const Text('Add Drink'),
            ),
          ],
        ),
      ),
    );
  }
}
