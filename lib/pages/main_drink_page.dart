import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drinkit/utils/colors.dart';
import 'package:drinkit/widgets/big_text.dart';
import 'package:drinkit/widgets/small_text.dart';
import 'package:drinkit/providers/cart_provider.dart';
import 'package:drinkit/providers/wishlist_provider.dart';
import '../models/drink.dart';
import '../services/api_service.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MainDrinkPage extends StatefulWidget {
  const MainDrinkPage({Key? key}) : super(key: key);

  @override
  _MainDrinkPageState createState() => _MainDrinkPageState();
}

class _MainDrinkPageState extends State<MainDrinkPage> {
  late Future<List<Drink>> _drinks;
  late List<Drink> _allDrinks;
  final ApiService apiService = ApiService();
  final TextEditingController _searchController = TextEditingController();
  List<Drink> _filteredDrinks = [];

  @override
  void initState() {
    super.initState();
    _drinks = apiService.fetchDrinks().then((drinks) {
      setState(() {
        _allDrinks = drinks;
        _filteredDrinks = drinks;
      });
      return drinks;
    });
  }

  void _filterDrinks(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredDrinks = _allDrinks;
      } else {
        _filteredDrinks = _allDrinks.where((drink) =>
            drink.name.toLowerCase().contains(query.toLowerCase())).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BigText(text: 'DrInKiT', color: Colors.white),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.store, color: Colors.white),
                  onPressed: () {
                    Navigator.pushNamed(context, '/drinks');
                  },
                ),
                IconButton(
                  icon: Icon(Icons.favorite, color: Colors.white),
                  onPressed: () {
                    Navigator.pushNamed(context, '/wishlist');
                  },
                ),
                IconButton(
                  icon: Icon(Icons.shopping_cart, color: Colors.white),
                  onPressed: () {
                    Navigator.pushNamed(context, '/cart');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<Drink>>(
        future: _drinks,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No drinks available'));
          } else {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: Center(
                      child: BigText(
                        text: 'Welcome to DrInKiT!',
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  
                  // Carousel Slider
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: CarouselSlider.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index, realIndex) {
                        final drink = snapshot.data![index];
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(drink.image_url),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        );
                      },
                      options: CarouselOptions(
                        height: 250,
                        enlargeCenterPage: true,
                        autoPlay: true,
                      ),
                    ),
                  ),

                  // Search Bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: _searchController,
                      onChanged: _filterDrinks,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Search for a drink...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Popular Drinks Header
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: BigText(
                      text: 'Popular Drinks',
                      color: AppColors.mainListColor,
                    ),
                  ),
                  
                  // Grid of Drinks
                  _filteredDrinks.isEmpty
                    ? Center(child: Text('No drinks available'))
                    : GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _filteredDrinks.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 3 / 4,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) {
                          final drink = _filteredDrinks[index];
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
                                          image: NetworkImage(drink.image_url),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.vertical(
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
                                      text: '\$${drink.price.toStringAsFixed(2)}',
                                      color: AppColors.mainListColor,
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
            child: Text('Add to Cart'),
          ),
          TextButton(
            onPressed: () {
              Provider.of<WishlistProvider>(context, listen: false)
                  .addToWishlist(drink);
              Navigator.of(context).pop();
            },
            child: Text('Add to Wishlist'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }
}
