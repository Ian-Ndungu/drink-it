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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Section
              const Text(
                'Privacy Policy',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Introduction
              const Text(
                'This Privacy Policy explains how we collect, use, and protect your information when you use our app. Please read this policy carefully to understand our views and practices regarding your personal data.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 20),

              // Sections
              _buildSection(
                title: '1. Information We Collect',
                content: 'We collect information you provide directly to us, such as your email address and any other personal details you choose to share. We may also collect information about your usage of the app, including your interaction with our services.',
              ),
              const SizedBox(height: 20),

              _buildSection(
                title: '2. How We Use Your Information',
                content: 'We use your information to provide and improve our services, communicate with you, and personalize your experience. Your information may also be used for research and analytics purposes.',
              ),
              const SizedBox(height: 20),

              _buildSection(
                title: '3. How We Protect Your Information',
                content: 'We implement various security measures to protect your personal data from unauthorized access, use, or disclosure. However, no method of transmission over the Internet or method of electronic storage is 100% secure.',
              ),
              const SizedBox(height: 20),

              _buildSection(
                title: '4. Your Rights',
                content: 'You have the right to access, correct, or delete your personal information. You may also have the right to restrict or object to certain processing of your data. Please contact us if you wish to exercise these rights.',
              ),
              const SizedBox(height: 20),

              _buildSection(
                title: '5. Changes to This Policy',
                content: 'We may update this Privacy Policy from time to time. Any changes will be posted on this page, and we will notify you of significant changes as required by law.',
              ),
              const SizedBox(height: 20),

              _buildSection(
                title: '6. Contact Us',
                content: 'If you have any questions about this Privacy Policy, please contact us at support@drinkit.com.',
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
