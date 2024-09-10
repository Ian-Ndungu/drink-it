import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drinkit/pages/admin_dashboard_page.dart';
import 'package:drinkit/pages/admin_manage_drinks_page.dart';
import 'package:drinkit/pages/admin_manage_orders_page.dart';
import 'package:drinkit/pages/admin_manage_users_page.dart';
import 'package:drinkit/pages/main_drink_page.dart';
import 'package:drinkit/pages/wishlist_page.dart';
import 'package:drinkit/pages/cart_page.dart';
import 'package:drinkit/pages/drinks_page.dart';
import 'package:drinkit/pages/login_page.dart';
import 'package:drinkit/pages/profile_page.dart';
import 'package:drinkit/pages/notifications_page.dart';
import 'package:drinkit/pages/chat_page.dart';
import 'package:drinkit/providers/cart_provider.dart';
import 'package:drinkit/providers/wishlist_provider.dart';
import 'package:drinkit/providers/loader_provider.dart';
import 'package:drinkit/providers/theme_provider.dart';
import 'package:drinkit/providers/notifications_provider.dart';
import 'package:drinkit/providers/chat_provider.dart';
import 'package:drinkit/providers/admin_provider.dart';
import 'package:drinkit/utils/theme_data.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => WishlistProvider()),
        ChangeNotifierProvider(create: (_) => LoaderProvider()),
        ChangeNotifierProvider(
            create: (_) => ThemeProvider(AppThemes.lightTheme)),
        ChangeNotifierProvider(create: (_) => NotificationsProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
        ChangeNotifierProvider(
            create: (_) => AdminProvider()), 
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
          title: 'Drink it',
          theme: themeProvider.getTheme(),
          initialRoute: '/login',
          routes: {
            '/login': (context) => const LoginPage(),
            '/': (context) => const MainDrinkPage(),
            '/drinks': (context) => const DrinksPage(),
            '/wishlist': (context) => const WishListPage(),
            '/cart': (context) => const CartPage(),
            '/profile': (context) => const ProfilePage(),
            '/notifications': (context) => const NotificationsPage(),
            '/chat': (context) => const ChatPage(),
            // Admin routes
            '/admin/dashboard': (context) => const AdminDashboardPage(),
            '/admin/manage-drinks': (context) => const AdminManageDrinksPage(),
            '/admin/manage-orders': (context) => const AdminManageOrdersPage(),
            '/admin/manage-users': (context) => const AdminManageUsersPage(),
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
