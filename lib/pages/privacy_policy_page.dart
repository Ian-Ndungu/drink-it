import 'package:flutter/material.dart';
import '../utils/colors.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        backgroundColor: AppColors.mainColor,
      ),
      body: const Center(
        child: Text('Privacy Policy Page'),
      ),
    );
  }
}
