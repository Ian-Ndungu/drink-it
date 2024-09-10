// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drinkit/providers/admin_provider.dart';

class AdminManageDrinksPage extends StatelessWidget {
  const AdminManageDrinksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final adminProvider = Provider.of<AdminProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Drinks'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: adminProvider.drinks.length,
              itemBuilder: (context, index) {
                final drink = adminProvider.drinks[index];
                return ListTile(
                  title: Text(drink.name),
                  subtitle: Text(drink.price.toString()),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      adminProvider.deleteDrink(drink);
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
              // Add drink functionality here
            },
            child: const Text('Add New Drink'),
          ),
        ],
      ),
    );
  }
}
