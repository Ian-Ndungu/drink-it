import 'package:flutter/material.dart';

class Notification {
  final String title;
  final String body;
  final String time;

  Notification({
    required this.title,
    required this.body,
    required this.time,
  });
}

class NotificationsProvider extends ChangeNotifier {
  final List<Notification> _notifications = [];

  List<Notification> get notifications => _notifications;

  void addNotification(Notification notification) {
    _notifications.add(notification);
    notifyListeners();
  }
}
