// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drinkit/pages/main_drink_page.dart';
import 'package:drinkit/pages/wishlist_page.dart';
import 'package:drinkit/pages/cart_page.dart';
import 'package:drinkit/pages/drinks_page.dart';
import 'package:drinkit/pages/login_page.dart';
import 'package:drinkit/pages/profile_page.dart'; // Import ProfilePage
import 'package:drinkit/providers/cart_provider.dart';
import 'package:drinkit/providers/wishlist_provider.dart';
import 'package:drinkit/providers/loader_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => WishlistProvider()),
        ChangeNotifierProvider(create: (_) => LoaderProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/login',
        routes: {
          '/login': (context) => const LoginPage(),
          '/': (context) => const MainDrinkPage(),
          '/drinks': (context) => const DrinksPage(),
          '/wishlist': (context) => const WishListPage(),
          '/cart': (context) => const CartPage(),
          '/profile': (context) => const ProfilePage(), // Add ProfilePage route
        },
        builder: (context, child) {
          return Stack(
            children: [
              child!,
              // Loader Overlay
              Consumer<LoaderProvider>(
                builder: (context, loaderProvider, child) {
                  if (loaderProvider.isLoading) {
                    return Positioned.fill(
                      child: Container(
                        color: Colors.black54,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
