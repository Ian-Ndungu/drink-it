import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../models/activity_log_entry.dart';
import 'activitylog_page.dart';
import '../utils/colors.dart';
import 'settings_page.dart';
import 'orders_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _email = '';
  String _profilePicUrl = '';
  File? _profilePicFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  void _loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _email = prefs.getString('email') ?? 'Guest';
      _profilePicUrl = prefs.getString('profilePicUrl') ?? '';
      if (_profilePicUrl.isNotEmpty) {
        _profilePicFile = File(_profilePicUrl);
      }
    });
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profilePicFile = File(pickedFile.path);
        _profilePicUrl = pickedFile.path;
      });
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profilePicUrl', _profilePicUrl);
      await _logActivity('Profile Picture Updated', 'Profile picture updated.');
    }
  }

  Future<void> _changePassword() async {
    String? newPassword = await showDialog<String>(
      context: context,
      builder: (context) {
        final TextEditingController controller = TextEditingController();
        return AlertDialog(
          title: const Text('Change Password'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(labelText: 'New Password'),
            obscureText: true,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(controller.text);
              },
              child: const Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );

    if (newPassword != null && newPassword.isNotEmpty) {
      // Handle password update logic here
      await _logActivity('Password Changed', 'Password was changed.');
    }
  }

  Future<void> _updateEmail() async {
    String? newEmail = await showDialog<String>(
      context: context,
      builder: (context) {
        final TextEditingController controller =
            TextEditingController(text: _email);
        return AlertDialog(
          title: const Text('Update Email'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(labelText: 'New Email'),
            keyboardType: TextInputType.emailAddress,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(controller.text);
              },
              child: const Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );

    if (newEmail != null && newEmail.isNotEmpty) {
      setState(() {
        _email = newEmail;
      });
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', _email);
      await _logActivity('Email Updated', 'Email updated to $newEmail');
    }
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    await prefs.remove('email');
    await prefs.remove('profilePicUrl');
    await _logActivity('Logged Out', 'User has logged out.');
    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, '/login');
  }

  void _viewProfilePic() {
    if (_profilePicFile != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              FullScreenImagePage(imageFile: _profilePicFile!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: AppColors.mainColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Profile Picture
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 80,
                backgroundColor: Colors.grey.shade300,
                backgroundImage: _profilePicFile != null
                    ? FileImage(_profilePicFile!)
                    : null,
                child: _profilePicFile == null
                    ? Icon(Icons.person, size: 80, color: Colors.grey.shade600)
                    : null,
              ),
            ),
            const SizedBox(height: 20),

            // View Profile Picture Button
            if (_profilePicFile != null) ...[
              ElevatedButton.icon(
                onPressed: _viewProfilePic,
                icon: const Icon(Icons.visibility),
                label: const Text('View Profile Picture'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mainColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),
            ],

            // Email
            Card(
              margin: const EdgeInsets.symmetric(vertical: 10),
              elevation: 4,
              child: ListTile(
                leading: const Icon(Icons.email, color: AppColors.mainColor),
                title: Text(
                  'Email: $_email',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                tileColor: AppColors.mainColor.withOpacity(0.1),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
            const SizedBox(height: 20),

            // Edit Email
            ListTile(
              onTap: _updateEmail,
              leading: const Icon(Icons.edit, color: AppColors.mainColor),
              title: const Text('Edit Email'),
              trailing: const Icon(Icons.arrow_forward_ios,
                  color: AppColors.mainColor),
              tileColor: AppColors.mainColor.withOpacity(0.1),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            const SizedBox(height: 20),

            // Change Password
            ListTile(
              onTap: _changePassword,
              leading: const Icon(Icons.lock, color: AppColors.mainColor),
              title: const Text('Change Password'),
              trailing: const Icon(Icons.arrow_forward_ios,
                  color: AppColors.mainColor),
              tileColor: AppColors.mainColor.withOpacity(0.1),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            const SizedBox(height: 20),

            // Activity Log
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ActivityLogPage(),
                  ),
                );
              },
              leading: const Icon(Icons.history, color: AppColors.mainColor),
              title: const Text('View Activity Log'),
              trailing: const Icon(Icons.arrow_forward_ios,
                  color: AppColors.mainColor),
              tileColor: AppColors.mainColor.withOpacity(0.1),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            const SizedBox(height: 20),

            // Orders
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OrdersPage(),
                  ),
                );
              },
              leading: const Icon(Icons.receipt, color: AppColors.mainColor),
              title: const Text('View Orders'),
              trailing: const Icon(Icons.arrow_forward_ios,
                  color: AppColors.mainColor),
              tileColor: AppColors.mainColor.withOpacity(0.1),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            const SizedBox(height: 20),

            // Settings
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsPage(),
                  ),
                );
              },
              leading: const Icon(Icons.settings, color: AppColors.mainColor),
              title: const Text('Settings'),
              trailing: const Icon(Icons.arrow_forward_ios,
                  color: AppColors.mainColor),
              tileColor: AppColors.mainColor.withOpacity(0.1),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _logActivity(String activityType, String details) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? logEntries = prefs.getStringList('activityLog') ?? [];
    final logEntry = ActivityLogEntry(
      activityType: activityType,
      timestamp: DateTime.now(),
      details: details,
    );
    logEntries.add(logEntry.toMap().toString());
    await prefs.setStringList('activityLog', logEntries);
  }
}

class FullScreenImagePage extends StatelessWidget {
  final File imageFile;

  const FullScreenImagePage({super.key, required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Picture'),
        backgroundColor: AppColors.mainColor,
      ),
      body: Center(
        child: Image.file(imageFile),
      ),
    );
  }
}
