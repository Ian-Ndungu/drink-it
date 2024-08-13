import 'package:flutter/material.dart';
import '../models/order.dart';
import '../utils/colors.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  Future<List<Order>> _loadOrders() async {
    // Replace this with actual logic to load orders from a database or API
    return [
      Order(id: '1', date: '2024-08-10', total: 15.99),
      Order(id: '2', date: '2024-08-11', total: 22.49),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
        backgroundColor: AppColors.mainColor,
      ),
      body: FutureBuilder<List<Order>>(
        future: _loadOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading orders'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No orders found'));
          }

          final orders = snapshot.data!;
          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 10),
                elevation: 4,
                child: ListTile(
                  leading: const Icon(Icons.receipt, color: AppColors.mainColor),
                  title: Text('Order #${order.id}'),
                  subtitle: Text('Date: ${order.date}\nTotal: \$${order.total}'),
                  isThreeLine: true,
                  tileColor: AppColors.mainColor.withOpacity(0.1),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  onTap: () {
                    // Handle order detail view if needed
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
