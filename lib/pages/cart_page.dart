import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drinkit/providers/cart_provider.dart';
import 'package:drinkit/providers/loader_provider.dart';
import 'package:drinkit/utils/colors.dart';
import 'package:drinkit/widgets/big_text.dart';
import 'package:drinkit/widgets/small_text.dart';
import 'package:drinkit/services/api_service.dart'; // Import your API service

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final ApiService _apiService = ApiService();

  Future<void> _checkout() async {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final loaderProvider = Provider.of<LoaderProvider>(context, listen: false);

    loaderProvider.showLoader();

    try {
      // Simulate order processing by calling your API
      await _apiService.processOrder(cartProvider.cart);

      // Clear the cart after successful order
      cartProvider.clearCart();

      // Show confirmation dialog
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Order Successful'),
          content: const Text('Your order has been placed successfully!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pushReplacementNamed('/'); // Navigate to the main page
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      // Handle error
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Order Failed'),
          content: Text('There was an error processing your order: $e'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } finally {
      loaderProvider.hideLoader();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final loaderProvider = Provider.of<LoaderProvider>(context);
    double totalPrice = cartProvider.getTotalPrice();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: const BigText(
          text: 'Your Cart',
          color: AppColors.iconColor,
          size: 20,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.remove_shopping_cart, color: AppColors.iconColor),
            onPressed: () {
              loaderProvider.showLoader();
              cartProvider.clearCart();
              Future.delayed(const Duration(seconds: 1), () {
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
                            borderRadius: const BorderRadius.horizontal(left: Radius.circular(20)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
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
                              const SizedBox(height: 5),
                              SmallText(
                                text: '\$${item.drink.price.toStringAsFixed(2)} x ${item.quantity}',
                                color: AppColors.mainListColor,
                                size: 14,
                              ),
                              const SizedBox(height: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SmallText(
                                    text: 'Total: \$${(item.drink.price * item.quantity).toStringAsFixed(2)}',
                                    color: AppColors.mainListColor,
                                    size: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.remove_circle, color: AppColors.smallColor),
                                        onPressed: () {
                                          cartProvider.removeFromCart(item.drink);
                                        },
                                      ),
                                      const SizedBox(width: 5),
                                      SmallText(
                                        text: '${item.quantity}',
                                        color: AppColors.mainListColor,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 5),
                                      IconButton(
                                        icon: const Icon(Icons.add_circle, color: AppColors.mainColor),
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
                const BigText(
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
                padding: const EdgeInsets.symmetric(vertical: 18),
              ),
              onPressed: _checkout,
              child: const Center(
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
