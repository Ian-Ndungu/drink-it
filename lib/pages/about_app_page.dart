import 'package:flutter/material.dart';
import '../utils/colors.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About App'),
        backgroundColor: AppColors.mainColor,
      ),
      body: const Center(
        child: Text('About App Page'),
      ),
    );
  }
}
