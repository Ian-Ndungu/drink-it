import 'package:flutter/material.dart';
import '../utils/colors.dart';

class PrivacySettingsPage extends StatelessWidget {
  const PrivacySettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Settings'),
        backgroundColor: AppColors.mainColor,
      ),
      body: const Center(
        child: Text('Privacy Settings Page'),
      ),
    );
  }
}
