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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Header
            const Text(
              'How can we help you?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // FAQ section
            const Text(
              'Frequently Asked Questions:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildFAQItem(
              'How do I reset my password?',
              'To reset your password, go to the login screen and tap on "Forgot Password". Follow the instructions to set a new password.',
            ),
            _buildFAQItem(
              'How can I contact support?',
              'You can contact our support team by emailing support@drinkit.com or calling 0717393483.',
            ),
            _buildFAQItem(
              'Where can I find the latest updates?',
              'For the latest updates and announcements, visit our website or follow us on social media.',
            ),
            const SizedBox(height: 20),

            // Contact support section
            const Text(
              'Need more help?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Implement contact support action
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Contact Support'),
                    content: const Text('You can reach our support team at support@drinkit.com or call 0717393483.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.mainColor,
              ),
              child: const Text('Contact Support'),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build FAQ items
  Widget _buildFAQItem(String question, String answer) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: ExpansionTile(
        title: Text(question),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(answer),
          ),
        ],
      ),
    );
  }
}
