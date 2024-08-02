import 'package:flutter/material.dart';
import '../utils/colors.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: AppColors.mainColor,
      ),
      body: ListView(
        children: [
          // Profile Settings
          ListTile(
            onTap: () {
              // Navigate to profile update page
            },
            leading: Icon(Icons.person, color: AppColors.mainColor),
            title: Text('Update Profile'),
            trailing: Icon(Icons.arrow_forward_ios, color: AppColors.mainColor),
            tileColor: AppColors.mainColor.withOpacity(0.1),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          SizedBox(height: 10),

          // Change Password
          ListTile(
            onTap: () {
              // Navigate to change password page
            },
            leading: Icon(Icons.lock, color: AppColors.mainColor),
            title: Text('Change Password'),
            trailing: Icon(Icons.arrow_forward_ios, color: AppColors.mainColor),
            tileColor: AppColors.mainColor.withOpacity(0.1),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          SizedBox(height: 10),

          // Theme Selection
          ListTile(
            onTap: () {
              // Navigate to theme selection page
            },
            leading: Icon(Icons.palette, color: AppColors.mainColor),
            title: Text('Theme'),
            trailing: Icon(Icons.arrow_forward_ios, color: AppColors.mainColor),
            tileColor: AppColors.mainColor.withOpacity(0.1),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          SizedBox(height: 10),

          // Notification Preferences
          ListTile(
            onTap: () {
              // Navigate to notification preferences page
            },
            leading: Icon(Icons.notifications, color: AppColors.mainColor),
            title: Text('Notifications'),
            trailing: Icon(Icons.arrow_forward_ios, color: AppColors.mainColor),
            tileColor: AppColors.mainColor.withOpacity(0.1),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          SizedBox(height: 10),

          // Privacy Settings
          ListTile(
            onTap: () {
              // Navigate to privacy settings page
            },
            leading: Icon(Icons.lock_outline, color: AppColors.mainColor),
            title: Text('Privacy Settings'),
            trailing: Icon(Icons.arrow_forward_ios, color: AppColors.mainColor),
            tileColor: AppColors.mainColor.withOpacity(0.1),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          SizedBox(height: 10),

          // Help & Support
          ListTile(
            onTap: () {
              // Navigate to help and support page
            },
            leading: Icon(Icons.help, color: AppColors.mainColor),
            title: Text('Help & Support'),
            trailing: Icon(Icons.arrow_forward_ios, color: AppColors.mainColor),
            tileColor: AppColors.mainColor.withOpacity(0.1),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          SizedBox(height: 10),

          // About App
          ListTile(
            onTap: () {
              // Navigate to about page
            },
            leading: Icon(Icons.info, color: AppColors.mainColor),
            title: Text('About App'),
            trailing: Icon(Icons.arrow_forward_ios, color: AppColors.mainColor),
            tileColor: AppColors.mainColor.withOpacity(0.1),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          SizedBox(height: 10),

          // Terms of Service
          ListTile(
            onTap: () {
              // Navigate to terms of service page
            },
            leading: Icon(Icons.article, color: AppColors.mainColor),
            title: Text('Terms of Service'),
            trailing: Icon(Icons.arrow_forward_ios, color: AppColors.mainColor),
            tileColor: AppColors.mainColor.withOpacity(0.1),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          SizedBox(height: 10),

          // Privacy Policy
          ListTile(
            onTap: () {
              // Navigate to privacy policy page
            },
            leading: Icon(Icons.policy, color: AppColors.mainColor),
            title: Text('Privacy Policy'),
            trailing: Icon(Icons.arrow_forward_ios, color: AppColors.mainColor),
            tileColor: AppColors.mainColor.withOpacity(0.1),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
