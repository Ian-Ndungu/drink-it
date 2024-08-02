import 'package:flutter/material.dart';
import '../utils/colors.dart';

class TermsOfServicePage extends StatelessWidget {
  const TermsOfServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms of Service'),
        backgroundColor: AppColors.mainColor,
      ),
      body: const Center(
        child: Text('Terms of Service Page'),
      ),
    );
  }
}
