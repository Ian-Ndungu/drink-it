// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drinkit/providers/admin_provider.dart';
import 'package:drinkit/services/api_service.dart';
import 'add_drink_page.dart';

class AdminManageDrinksPage extends StatelessWidget {
  const AdminManageDrinksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final adminProvider = Provider.of<AdminProvider>(context);
    final apiService = ApiService(); // Create an instance of ApiService

    Future<void> fetchDrinks() async {
      try {
        final drinks = await apiService.fetchDrinks();
        adminProvider.setDrinks(drinks);
      } catch (error) {
        print('Failed to fetch drinks: $error');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Drinks'),
      ),
      body: FutureBuilder<void>(
        future: fetchDrinks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            if (adminProvider.drinks.isEmpty) {
              return const Center(child: Text('No drinks available'));
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: adminProvider.drinks.length,
                    itemBuilder: (context, index) {
                      final drink = adminProvider.drinks[index];
                      return ListTile(
                        leading: drink.image_url.isNotEmpty
                            ? Image.network(drink.image_url)
                            : null,
                        title: Text(drink.name),
                        subtitle: Text('\$${drink.price.toStringAsFixed(2)}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Confirm Deletion'),
                                  content: Text('Are you sure you want to delete ${drink.name}?'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('Cancel'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: const Text('Delete'),
                                      onPressed: () {
                                        adminProvider.deleteDrink(drink);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                        onTap: () {
                          // Edit drink functionality here
                        },
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddDrinkPage(),
                      ),
                    );
                  },
                  child: const Text('Add New Drink'),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
