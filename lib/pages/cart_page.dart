import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drinkit/providers/cart_provider.dart';
import 'package:drinkit/utils/colors.dart';
import 'package:drinkit/widgets/big_text.dart';
import 'package:drinkit/widgets/small_text.dart';
import 'package:drinkit/providers/loader_provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final loaderProvider = Provider.of<LoaderProvider>(context);
    double totalPrice = cartProvider.getTotalPrice();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: BigText(
          text: 'Your Cart',
          color: AppColors.iconColor,
          size: 20,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.remove_shopping_cart, color: AppColors.iconColor),
            onPressed: () {
              loaderProvider.showLoader();
              cartProvider.clearCart();
              Future.delayed(Duration(seconds: 1), () {
                loaderProvider.hideLoader();
              });
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartProvider.cart.length,
              itemBuilder: (context, index) {
                final item = cartProvider.cart[index];
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  decoration: BoxDecoration(
                    color: AppColors.mainColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 120,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(item.drink.image_url),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.horizontal(left: Radius.circular(20)),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SmallText(
                                text: item.drink.name,
                                color: AppColors.mainListColor,
                                size: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              SizedBox(height: 5),
                              SmallText(
                                text: '\$${item.drink.price.toStringAsFixed(2)} x ${item.quantity}',
                                color: AppColors.mainListColor,
                                size: 14,
                              ),
                              SizedBox(height: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SmallText(
                                    text: 'Total: \$${(item.drink.price * item.quantity).toStringAsFixed(2)}',
                                    color: AppColors.mainListColor,
                                    size: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.remove_circle, color: AppColors.smallColor),
                                        onPressed: () {
                                          cartProvider.removeFromCart(item.drink);
                                        },
                                      ),
                                      SizedBox(width: 5),
                                      SmallText(
                                        text: '${item.quantity}',
                                        color: AppColors.mainListColor,
                                        size: 16,
                                      ),
                                      SizedBox(width: 5),
                                      IconButton(
                                        icon: Icon(Icons.add_circle, color: AppColors.mainColor),
                                        onPressed: () {
                                          cartProvider.addToCart(item.drink);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BigText(
                  text: 'Total Price:',
                  color: AppColors.mainListColor,
                  size: 18,
                ),
                BigText(
                  text: '\$${totalPrice.toStringAsFixed(2)}',
                  color: AppColors.mainColor,
                  size: 18,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.mainColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: EdgeInsets.symmetric(vertical: 18),
              ),
              onPressed: () {
                loaderProvider.showLoader();
                Future.delayed(Duration(seconds: 2), () {
                  loaderProvider.hideLoader();
                });
              },
              child: Center(
                child: BigText(
                  text: 'Checkout',
                  color: AppColors.iconColor,
                  size: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
