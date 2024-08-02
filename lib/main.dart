import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drinkit/pages/main_drink_page.dart';
import 'package:drinkit/pages/wishlist_page.dart';
import 'package:drinkit/pages/cart_page.dart';
import 'package:drinkit/pages/drinks_page.dart';
import 'package:drinkit/pages/login_page.dart';
import 'package:drinkit/pages/profile_page.dart'; 
import 'package:drinkit/pages/notifications_page.dart'; // Import the notifications page
import 'package:drinkit/providers/cart_provider.dart';
import 'package:drinkit/providers/wishlist_provider.dart';
import 'package:drinkit/providers/loader_provider.dart';
import 'package:drinkit/providers/theme_provider.dart'; 
import 'package:drinkit/providers/notifications_provider.dart'; // Import the notifications provider
import 'package:drinkit/utils/theme_data.dart'; 

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => WishlistProvider()),
        ChangeNotifierProvider(create: (_) => LoaderProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider(AppThemes.lightTheme)),
        ChangeNotifierProvider(create: (_) => NotificationsProvider()), // Register the NotificationsProvider
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: themeProvider.getTheme(), 
          initialRoute: '/login',
          routes: {
            '/login': (context) => const LoginPage(),
            '/': (context) => const MainDrinkPage(),
            '/drinks': (context) => const DrinksPage(),
            '/wishlist': (context) => const WishListPage(),
            '/cart': (context) => const CartPage(),
            '/profile': (context) => const ProfilePage(),
            '/notifications': (context) => const NotificationsPage(), // Add the notifications route
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
        );
      },
    );
  }
}
