import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drinkit/providers/wishlist_provider.dart';
import 'package:drinkit/providers/cart_provider.dart';
import 'package:drinkit/utils/colors.dart';
import 'package:drinkit/widgets/big_text.dart';
import 'package:drinkit/widgets/small_text.dart';

class WishListPage extends StatelessWidget {
  const WishListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wishlist = Provider.of<WishlistProvider>(context).wishlist;

    return Scaffold(
      appBar: AppBar(
        title: BigText(text: 'Wish List', color: Colors.white),
        backgroundColor: AppColors.mainColor,
      ),
      body: wishlist.isEmpty
          ? Center(child: Text('Your wish list is empty'))
          : ListView.builder(
              itemCount: wishlist.length,
              itemBuilder: (context, index) {
                final wishlistItem = wishlist[index];
                return ListTile(
                  leading: Image.network(wishlistItem.drink.image_url),
                  title: BigText(text: wishlistItem.drink.name, color: Colors.black),
                  subtitle: SmallText(
                      text: '\$${(wishlistItem.drink.price * wishlistItem.quantity).toStringAsFixed(2)}',
                      color: Colors.black),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${wishlistItem.quantity}',
                        style: TextStyle(color: Colors.black),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          Provider.of<WishlistProvider>(context, listen: false)
                              .removeFromWishlist(wishlistItem.drink);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.add_shopping_cart, color: Colors.green),
                        onPressed: () {
                          final cartProvider =
                              Provider.of<CartProvider>(context, listen: false);
                          cartProvider.addToCart(wishlistItem.drink);
                          Provider.of<WishlistProvider>(context, listen: false)
                              .removeFromWishlist(wishlistItem.drink);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
