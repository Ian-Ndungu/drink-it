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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Section
              const Text(
                'Terms of Service',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Introduction
              const Text(
                'Welcome to our Terms of Service page. Here you will find all the information about the terms and conditions that govern your use of our application.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 20),

              // Sections
              _buildSection(
                title: '1. Introduction',
                content:
                    'These Terms of Service govern your use of our app. By using our app, you agree to these terms.',
              ),
              const SizedBox(height: 20),

              _buildSection(
                title: '2. User Responsibilities',
                content:
                    'You are responsible for maintaining the confidentiality of your account and for all activities that occur under your account.',
              ),
              const SizedBox(height: 20),

              _buildSection(
                title: '3. Limitation of Liability',
                content:
                    'Our liability is limited to the maximum extent permitted by law. We are not liable for any indirect, incidental, or consequential damages.',
              ),
              const SizedBox(height: 20),

              _buildSection(
                title: '4. Changes to Terms',
                content:
                    'We may update these terms from time to time. You will be notified of any significant changes.',
              ),
              const SizedBox(height: 20),

              _buildSection(
                title: '5. Contact Us',
                content:
                    'If you have any questions about these Terms of Service, please contact us at support@drinkit.com.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build sections
  Widget _buildSection({required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}
