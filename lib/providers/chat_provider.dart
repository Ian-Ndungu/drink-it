import 'package:flutter/material.dart';

class Message {
  final String text;
  final bool isCustomer;
  bool isRead;

  Message({
    required this.text,
    required this.isCustomer,
    this.isRead = false,
  });
}

class ChatProvider with ChangeNotifier {
  List<Message> _messages = [];

  List<Message> get messages => _messages;

  void sendMessage(String text) {
    final newMessage = Message(
      text: text,
      isCustomer: true, // Assuming the user is the customer
    );
    _messages.insert(0, newMessage);
    notifyListeners();

    // Simulate a response from the support after a delay
    Future.delayed(const Duration(seconds: 1), () {
      final response = Message(
        text: 'Thank you for your message!',
        isCustomer: false, // Support message
      );
      _messages.insert(0, response);
      notifyListeners();
    });
  }

  void markMessageAsRead(int index) {
    if (index >= 0 && index < _messages.length) {
      _messages[index].isRead = true;
      notifyListeners();
    }
  }

  void clearChat() {
    _messages.clear();
    notifyListeners();
  }
}
