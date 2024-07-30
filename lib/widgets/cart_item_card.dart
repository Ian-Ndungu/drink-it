// cart_item_card.dart

import 'package:flutter/material.dart';
import 'package:drinkit/widgets/small_text.dart';
import 'package:drinkit/providers/cart_provider.dart';
import 'package:provider/provider.dart';
import '../models/drink.dart';  // Import your Drink model

class CartItemCard extends StatelessWidget {
  final Drink drink;  

  const CartItemCard({
    Key? key,
    required this.drink,  
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: ListTile(
        leading: Image.network(drink.image_url, fit: BoxFit.cover, width: 60, height: 60),
        title: SmallText(text: drink.name, color: Colors.black),
        subtitle: SmallText(text: '\$${drink.price.toStringAsFixed(2)}', color: Colors.black),
        trailing: IconButton(
          icon: Icon(Icons.remove_circle, color: Colors.red),
          onPressed: () {
            cartProvider.removeFromCart(drink); 
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${drink.name} removed from cart')),
            );
          },
        ),
      ),
    );
  }
}
