import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/notifications_provider.dart'; // You'll need to create this provider
import '../widgets/big_text.dart';
import '../widgets/small_text.dart';
import '../utils/colors.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: const BigText(text: 'Notifications', color: Colors.white),
      ),
      body: Consumer<NotificationsProvider>(
        builder: (context, notificationsProvider, child) {
          final notifications = notificationsProvider.notifications;
          return notifications.isEmpty
              ? const Center(child: Text('No notifications available'))
              : ListView.builder(
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    final notification = notifications[index];
                    return ListTile(
                      leading: const Icon(Icons.notifications, color: AppColors.mainColor),
                      title: SmallText(text: notification.title),
                      subtitle: SmallText(text: notification.body),
                      trailing: Text(notification.time, style: const TextStyle(color: AppColors.listColor)),
                      onTap: () {
                        // Handle tap on notification
                      },
                    );
                  },
                );
        },
      ),
    );
  }
}
