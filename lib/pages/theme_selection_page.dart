import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drinkit/providers/theme_provider.dart';
import '../utils/colors.dart';
import '../utils/theme_data.dart'; 

class ThemeSelectionPage extends StatelessWidget {
  const ThemeSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Theme'),
        backgroundColor: AppColors.mainColor,
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: () {
              Provider.of<ThemeProvider>(context, listen: false)
                  .setTheme(AppThemes.lightTheme);
              Navigator.pop(context); // Go back to previous page
            },
            leading: const Icon(Icons.wb_sunny, color: AppColors.mainColor),
            title: const Text('Light Theme'),
            tileColor: AppColors.mainColor.withOpacity(0.1),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          const SizedBox(height: 10),
          ListTile(
            onTap: () {
              Provider.of<ThemeProvider>(context, listen: false)
                  .setTheme(AppThemes.darkTheme);
              Navigator.pop(context); // Go back to previous page
            },
            leading: const Icon(Icons.nightlight_round, color: AppColors.mainColor),
            title: const Text('Dark Theme'),
            tileColor: AppColors.mainColor.withOpacity(0.1),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ],
      ),
    );
  }
}
