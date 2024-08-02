import 'package:flutter/material.dart';
import '../utils/colors.dart';

class NotificationPreferencesPage extends StatelessWidget {
  const NotificationPreferencesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Preferences'),
        backgroundColor: AppColors.mainColor,
      ),
      body: const Center(
        child: Text('Notification Preferences Page'),
      ),
    );
  }
}
