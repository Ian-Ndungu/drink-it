import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:drinkit/utils/colors.dart';

class ActivityLogPage extends StatelessWidget {
  const ActivityLogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity Log'),
        backgroundColor: AppColors.mainColor,
      ),
      body: FutureBuilder<List<String>>(
        future: _getActivityLogEntries(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No activity log available.'));
          }
          final logEntries = snapshot.data!;
          return ListView.builder(
            itemCount: logEntries.length,
            itemBuilder: (context, index) {
              final logEntry = logEntries[index];
              return ListTile(
                title: Text(logEntry),
                subtitle: Text('Details here'), // Parse details if needed
                leading: Icon(Icons.history, color: AppColors.mainColor),
              );
            },
          );
        },
      ),
    );
  }

  Future<List<String>> _getActivityLogEntries() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('activityLog') ?? [];
  }
}
