import 'package:flutter/material.dart';
import '../utils/colors.dart';
import 'theme_selection_page.dart';
import 'notification_preferences_page.dart';
import 'privacy_settings_page.dart';
import 'help_support_page.dart';
import 'about_app_page.dart';
import 'terms_of_service_page.dart';
import 'privacy_policy_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: AppColors.mainColor,
      ),
      body: ListView(
        children: [
          // Theme Selection
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ThemeSelectionPage()),
              );
            },
            leading: const Icon(Icons.palette, color: AppColors.mainColor),
            title: const Text('Theme'),
            trailing: const Icon(Icons.arrow_forward_ios, color: AppColors.mainColor),
            tileColor: AppColors.mainColor.withOpacity(0.1),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          const SizedBox(height: 10),

          // Notification Preferences
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NotificationPreferencesPage()),
              );
            },
            leading: const Icon(Icons.notifications, color: AppColors.mainColor),
            title: const Text('Notifications'),
            trailing: const Icon(Icons.arrow_forward_ios, color: AppColors.mainColor),
            tileColor: AppColors.mainColor.withOpacity(0.1),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          const SizedBox(height: 10),

          // Privacy Settings
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PrivacySettingsPage()),
              );
            },
            leading: const Icon(Icons.lock_outline, color: AppColors.mainColor),
            title: const Text('Privacy Settings'),
            trailing: const Icon(Icons.arrow_forward_ios, color: AppColors.mainColor),
            tileColor: AppColors.mainColor.withOpacity(0.1),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          const SizedBox(height: 10),

          // Help & Support
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const HelpSupportPage()),
              );
            },
            leading: const Icon(Icons.help, color: AppColors.mainColor),
            title: const Text('Help & Support'),
            trailing: const Icon(Icons.arrow_forward_ios, color: AppColors.mainColor),
            tileColor: AppColors.mainColor.withOpacity(0.1),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          const SizedBox(height: 10),

          // About App
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutAppPage()),
              );
            },
            leading: const Icon(Icons.info, color: AppColors.mainColor),
            title: const Text('About App'),
            trailing: const Icon(Icons.arrow_forward_ios, color: AppColors.mainColor),
            tileColor: AppColors.mainColor.withOpacity(0.1),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          const SizedBox(height: 10),

          // Terms of Service
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const TermsOfServicePage()),
              );
            },
            leading: const Icon(Icons.article, color: AppColors.mainColor),
            title: const Text('Terms of Service'),
            trailing: const Icon(Icons.arrow_forward_ios, color: AppColors.mainColor),
            tileColor: AppColors.mainColor.withOpacity(0.1),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          const SizedBox(height: 10),

          // Privacy Policy
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PrivacyPolicyPage()),
              );
            },
            leading: const Icon(Icons.policy, color: AppColors.mainColor),
            title: const Text('Privacy Policy'),
            trailing: const Icon(Icons.arrow_forward_ios, color: AppColors.mainColor),
            tileColor: AppColors.mainColor.withOpacity(0.1),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
