import 'package:flutter/material.dart';
import '../utils/colors.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
        backgroundColor: AppColors.mainColor,
      ),
      body: const Center(
        child: Text('Help & Support Page'),
      ),
    );
  }
}
