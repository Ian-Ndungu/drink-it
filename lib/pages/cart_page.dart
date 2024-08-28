import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:drinkit/providers/cart_provider.dart';
import 'package:drinkit/providers/loader_provider.dart';
import 'package:drinkit/utils/colors.dart';
import 'package:drinkit/widgets/big_text.dart';
import 'package:drinkit/widgets/small_text.dart';
import 'package:drinkit/services/api_service.dart';
import 'package:drinkit/widgets/map_picker.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final ApiService _apiService = ApiService();
  String? _selectedLocation;
  LatLng? _pickedLatLng;
  final TextEditingController _phoneController = TextEditingController();

  Future<String?> _getLocationName(LatLng latLng) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        return '${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}';
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  String _formatLatLng(LatLng latLng) {
    return 'Lat: ${latLng.latitude.toStringAsFixed(4)}, Lng: ${latLng.longitude.toStringAsFixed(4)}';
  }

  Future<void> _checkout() async {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final loaderProvider = Provider.of<LoaderProvider>(context, listen: false);

    final phoneNumber = _phoneController.text.trim();

    if (_selectedLocation == null) {
      _showErrorDialog('Please select a delivery location.');
      return;
    }

    if (phoneNumber.isEmpty) {
      _showErrorDialog('Please enter your phone number.');
      return;
    }

    loaderProvider.showLoader();

    try {
      await _apiService.processOrder(
          cartProvider.cart, phoneNumber, _pickedLatLng);
      cartProvider.clearCart();

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Order Successful'),
          content: const Text('Your order has been placed successfully!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed('/');
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Order Failed'),
          content: Text('There was an error processing your order: $e'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
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

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
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
            icon: const Icon(Icons.remove_shopping_cart,
                color: AppColors.iconColor),
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
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
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
                            borderRadius: const BorderRadius.horizontal(
                                left: Radius.circular(20)),
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
                                text:
                                    '\$${item.drink.price.toStringAsFixed(2)} x ${item.quantity}',
                                color: AppColors.mainListColor,
                                size: 14,
                              ),
                              const SizedBox(height: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SmallText(
                                    text:
                                        'Total: \$${(item.drink.price * item.quantity).toStringAsFixed(2)}',
                                    color: AppColors.mainListColor,
                                    size: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.remove_circle,
                                            color: AppColors.smallColor),
                                        onPressed: () {
                                          cartProvider
                                              .removeFromCart(item.drink);
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
                                        icon: const Icon(Icons.add_circle,
                                            color: AppColors.mainColor),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BigText(
                  text: 'Select Delivery Location:',
                  color: AppColors.mainListColor,
                  size: 18,
                ),
                const SizedBox(height: 5),
                GestureDetector(
                  onTap: () async {
                    final LatLng? result = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const MapPicker(),
                      ),
                    );

                    if (result != null) {
                      final locationName = await _getLocationName(result);
                      setState(() {
                        _pickedLatLng = result;
                        _selectedLocation =
                            locationName ?? _formatLatLng(result);
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: AppColors.mainColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.mainColor, width: 1),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.location_on, color: AppColors.mainColor),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            _selectedLocation ?? 'Tap to select location',
                            style: TextStyle(
                              color: _selectedLocation != null
                                  ? AppColors.mainListColor
                                  : AppColors.listColor,
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Phone Number',
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: loaderProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: _checkout,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.mainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 30),
                    ),
                    child: const Text('Checkout',
                        style: TextStyle(color: Colors.white)),
                  ),
          ),
        ],
      ),
    );
  }
}
