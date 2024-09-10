// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drinkit/providers/admin_provider.dart';

class AdminManageOrdersPage extends StatelessWidget {
  const AdminManageOrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final adminProvider = Provider.of<AdminProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Orders'),
      ),
      body: ListView.builder(
        itemCount: adminProvider.orders.length,
        itemBuilder: (context, index) {
          final order = adminProvider.orders[index];
          return ListTile(
            title: Text('Order #${order.id}'),
            subtitle: Text('Status: ${order.status}'),
            trailing: ElevatedButton(
              onPressed: () {
                // Update order status here
              },
              child: const Text('Update Status'),
            ),
          );
        },
      ),
    );
  }
}
