import 'package:flutter/material.dart';
import '../utils/colors.dart';

class NotificationPreferencesPage extends StatefulWidget {
  const NotificationPreferencesPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NotificationPreferencesPageState createState() => _NotificationPreferencesPageState();
}

class _NotificationPreferencesPageState extends State<NotificationPreferencesPage> {
  // State variables to hold the notification preferences
  bool _emailNotifications = true;
  bool _pushNotifications = false;
  bool _smsNotifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Preferences'),
        backgroundColor: AppColors.mainColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Manage your notification preferences:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            SwitchListTile(
              title: const Text('Email Notifications'),
              value: _emailNotifications,
              onChanged: (bool value) {
                setState(() {
                  _emailNotifications = value;
                });
              },
            ),
            SwitchListTile(
              title: const Text('Push Notifications'),
              value: _pushNotifications,
              onChanged: (bool value) {
                setState(() {
                  _pushNotifications = value;
                });
              },
            ),
            SwitchListTile(
              title: const Text('SMS Notifications'),
              value: _smsNotifications,
              onChanged: (bool value) {
                setState(() {
                  _smsNotifications = value;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement save preferences action
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Preferences saved')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.mainColor,
              ),
              child: const Text('Save Preferences'),
            ),
          ],
        ),
      ),
    );
  }
}
