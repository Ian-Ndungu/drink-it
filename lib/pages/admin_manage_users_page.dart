import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drinkit/providers/admin_provider.dart';
import 'package:drinkit/utils/colors.dart';

class AdminManageUsersPage extends StatelessWidget {
  const AdminManageUsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final adminProvider = Provider.of<AdminProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Users'),
        backgroundColor: AppColors.mainColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
          separatorBuilder: (context, index) =>
              const Divider(height: 20, thickness: 1.5),
          itemCount: adminProvider.users.length,
          itemBuilder: (context, index) {
            final user = adminProvider.users[index];
            return Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16.0),
                leading: CircleAvatar(
                  backgroundImage: user.imageUrl.isNotEmpty
                      ? AssetImage(user.imageUrl) as ImageProvider
                      : const AssetImage('assets/images/default_avatar.png'),
                  child: user.imageUrl.isEmpty
                      ? Text(
                          user.email.isNotEmpty
                              ? user.email[0].toUpperCase()
                              : '?',
                          style: const TextStyle(color: Colors.white),
                        )
                      : null,
                ),
                title: Text(
                  user.email,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Role: ${user.role}',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                trailing: ElevatedButton(
                  onPressed: () {
                    _showManageUserDialog(context, user, adminProvider);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('Manage'),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showManageUserDialog(
      BuildContext context, User user, AdminProvider adminProvider) {
    final List<String> roles = ['Admin', 'User', 'Moderator'];
    String selectedRole = user.role;

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 16.0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Manage ${user.email}',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 16.0),
                DropdownButtonFormField<String>(
                  value: selectedRole,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      selectedRole = newValue;
                    }
                  },
                  items: roles.map((role) {
                    return DropdownMenuItem<String>(
                      value: role,
                      child: Text(role),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Select Role',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
                  ),
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        adminProvider.updateUserRole(user.email, selectedRole);
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.mainColor,
                        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      child: const Text('Change Role'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        adminProvider.deleteUser(user);
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 235, 45, 32),
                        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      child: const Text('Delete User'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
