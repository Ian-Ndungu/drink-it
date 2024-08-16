// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drinkit/utils/colors.dart';
import 'package:drinkit/widgets/big_text.dart';
import 'package:drinkit/widgets/small_text.dart';
import 'package:drinkit/providers/cart_provider.dart';
import 'package:drinkit/providers/wishlist_provider.dart';
import 'package:drinkit/widgets/category_chip.dart'; 
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/drink.dart';
import '../services/api_service.dart';

class DrinksPage extends StatefulWidget {
  const DrinksPage({super.key});

  @override
  _DrinksPageState createState() => _DrinksPageState();
}

class _DrinksPageState extends State<DrinksPage> {
  late Future<List<Drink>> _drinks;
  final ApiService apiService = ApiService();

  // Category selection state
  String _selectedCategory = 'All';
  final List<String> _categories = [];

  @override
  void initState() {
    super.initState();
    _drinks = apiService.fetchDrinks();
    _categories.add('All');
    _categories.addAll([
      'Coffee',
      'Tea',
      'Soft Drink',
      'Spirit',
      'Cocktail',
      'Mocktail',
      'Juice',
      'Water',
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: const Row(
          children: [
            Icon(FontAwesomeIcons.cocktail, color: Colors.white), // Fancy icon
            SizedBox(width: 10),
            BigText(text: 'Drinks', color: Colors.white),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCategoryFilter(),
          Expanded(
            child: FutureBuilder<List<Drink>>(
              future: _drinks,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No drinks available'));
                } else {
                  final filteredDrinks = snapshot.data!
                      .where((drink) =>
                          drink.category == _selectedCategory ||
                          _selectedCategory == 'All')
                      .toList();

                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: BigText(
                            text: 'All Drinks',
                            color: AppColors.mainListColor,
                          ),
                        ),
                        GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: filteredDrinks.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 3 / 4,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemBuilder: (context, index) {
                            final drink = filteredDrinks[index];
                            return GestureDetector(
                              onTap: () {
                                _showDrinkDialog(context, drink);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.mainColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image:
                                                NetworkImage(drink.image_url),
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius:
                                              const BorderRadius.vertical(
                                                  top: Radius.circular(20)),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SmallText(
                                        text: drink.name,
                                        color: AppColors.mainListColor,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SmallText(
                                        text:
                                            '\$${drink.price.toStringAsFixed(2)}',
                                        color: AppColors.smallColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _categories.map((category) {
            return CategoryChip(
              category: category,
              isSelected: category == _selectedCategory,
              onSelected: (selectedCategory) {
                setState(() {
                  _selectedCategory = selectedCategory;
                  _drinks = apiService.fetchDrinks(); // Re-fetch drinks
                });
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showDrinkDialog(BuildContext context, Drink drink) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(drink.name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(drink.image_url),
            Text('\$${drink.price.toStringAsFixed(2)}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Provider.of<CartProvider>(context, listen: false)
                  .addToCart(drink);
              Navigator.of(context).pop();
            },
            child: const Text('Add to Cart'),
          ),
          TextButton(
            onPressed: () {
              Provider.of<WishlistProvider>(context, listen: false)
                  .addToWishlist(drink);
              Navigator.of(context).pop();
            },
            child: const Text('Add to Wishlist'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}
