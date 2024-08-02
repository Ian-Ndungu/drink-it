import 'package:flutter/material.dart';
import '../utils/colors.dart';

class PrivacySettingsPage extends StatefulWidget {
  const PrivacySettingsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PrivacySettingsPageState createState() => _PrivacySettingsPageState();
}

class _PrivacySettingsPageState extends State<PrivacySettingsPage> {
  // State variables for privacy settings
  bool _profileVisibility = true;
  bool _activityVisibility = false;
  bool _searchVisibility = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Settings'),
        backgroundColor: AppColors.mainColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Manage your privacy settings:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            SwitchListTile(
              title: const Text('Profile Visibility'),
              subtitle: const Text('Control who can see your profile'),
              value: _profileVisibility,
              onChanged: (bool value) {
                setState(() {
                  _profileVisibility = value;
                });
              },
            ),
            SwitchListTile(
              title: const Text('Activity Visibility'),
              subtitle: const Text('Control who can see your activity'),
              value: _activityVisibility,
              onChanged: (bool value) {
                setState(() {
                  _activityVisibility = value;
                });
              },
            ),
            SwitchListTile(
              title: const Text('Search Visibility'),
              subtitle: const Text('Control if your profile can be found via search'),
              value: _searchVisibility,
              onChanged: (bool value) {
                setState(() {
                  _searchVisibility = value;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement save settings action
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Settings saved')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.mainColor,
              ),
              child: const Text('Save Settings'),
            ),
          ],
        ),
      ),
    );
  }
}
