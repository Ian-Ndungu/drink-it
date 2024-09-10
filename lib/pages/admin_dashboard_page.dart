// ignore_for_file: use_super_parameters, library_private_types_in_public_api

import 'package:drinkit/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';

Stream<Map<String, int>> getOverviewDataStream() async* {
  int index = 0;
  while (true) {
    await Future.delayed(const Duration(seconds: 2));
    yield {
      'Total Users': 100 + (index++ % 20),
      'Total Orders': 300 + (index % 50),
      'Total Revenue': 15000 + (index % 1000),
    };
  }
}

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({Key? key}) : super(key: key);

  @override
  _AdminDashboardPageState createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  DateTimeRange? _selectedDateRange;
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: const Text('Admin Dashboard'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: AppColors.mainColor,
              ),
              child: Text(
                'Admin Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading:
                  const Icon(Icons.local_drink, color: AppColors.mainColor),
              title: const Text('Manage Drinks'),
              onTap: () {
                Navigator.pushNamed(context, '/admin/manage-drinks');
              },
            ),
            ListTile(
              leading:
                  const Icon(Icons.shopping_cart, color: AppColors.mainColor),
              title: const Text('Manage Orders'),
              onTap: () {
                Navigator.pushNamed(context, '/admin/manage-orders');
              },
            ),
            ListTile(
              leading: const Icon(Icons.person, color: AppColors.mainColor),
              title: const Text('Manage Users'),
              onTap: () {
                Navigator.pushNamed(context, '/admin/manage-users');
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dashboard Overview',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.black,
                    ),
              ),
              const SizedBox(height: 20),
              // Date Range Selector
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: _selectDateRange,
                    icon: const Icon(Icons.calendar_today, color: Colors.white),
                    label: Text(
                      _selectedDateRange == null
                          ? 'Select Date Range'
                          : 'Selected: ${_dateFormat.format(_selectedDateRange!.start)} - ${_dateFormat.format(_selectedDateRange!.end)}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: AppColors.pageColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      elevation: 5,
                      shadowColor: Colors.black.withOpacity(0.3),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Real-time Overview with Enhanced Borders
              StreamBuilder<Map<String, int>>(
                stream: getOverviewDataStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    final data = snapshot.data!;
                    return Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.greenAccent, AppColors.pageColor],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildMetricCard(
                              title: 'Total Users',
                              value: '${data['Total Users']}',
                            ),
                            _buildMetricCard(
                              title: 'Total Orders',
                              value: '${data['Total Orders']}',
                            ),
                            _buildMetricCard(
                              title: 'Total Revenue',
                              value: '\$${data['Total Revenue']}',
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const Center(child: Text('No data available'));
                  }
                },
              ),
              const SizedBox(height: 20),
              // Charts in column form
              SizedBox(
                height: 400, // Define a fixed height for the charts container
                child: Column(
                  children: [
                    Expanded(
                      child: Card(
                        color: Colors.white,
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Users Created',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Expanded(
                                child: BarChart(
                                  BarChartData(
                                    gridData: const FlGridData(show: false),
                                    titlesData: const FlTitlesData(show: false),
                                    borderData: FlBorderData(
                                      show: true,
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                    ),
                                    barGroups: [
                                      BarChartGroupData(x: 0, barRods: [
                                        BarChartRodData(
                                          toY: 5,
                                          color: Colors.blueAccent,
                                        ),
                                      ]),
                                      BarChartGroupData(x: 1, barRods: [
                                        BarChartRodData(
                                          toY: 10,
                                          color: Colors.blueAccent,
                                        ),
                                      ]),
                                      BarChartGroupData(x: 2, barRods: [
                                        BarChartRodData(
                                          toY: 8,
                                          color: Colors.blueAccent,
                                        ),
                                      ]),
                                      BarChartGroupData(x: 3, barRods: [
                                        BarChartRodData(
                                          toY: 15,
                                          color: Colors.blueAccent,
                                        ),
                                      ]),
                                      BarChartGroupData(x: 4, barRods: [
                                        BarChartRodData(
                                          toY: 12,
                                          color: Colors.blueAccent,
                                        ),
                                      ]),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: Card(
                        color: Colors.white,
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Orders Made',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Expanded(
                                child: LineChart(
                                  LineChartData(
                                    gridData: const FlGridData(show: false),
                                    titlesData: const FlTitlesData(show: false),
                                    borderData: FlBorderData(
                                      show: true,
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                    ),
                                    minX: 0,
                                    maxX: 6,
                                    minY: 0,
                                    maxY: 20,
                                    lineBarsData: [
                                      LineChartBarData(
                                        spots: [
                                          const FlSpot(0, 5),
                                          const FlSpot(1, 10),
                                          const FlSpot(2, 7),
                                          const FlSpot(3, 15),
                                          const FlSpot(4, 12),
                                        ],
                                        isCurved: true,
                                        color: Colors.blueAccent,
                                        dotData: const FlDotData(show: true),
                                        belowBarData: BarAreaData(show: false),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Recent Users Section
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Recent Users',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _buildUserCard('iannjagah@gmail.com', 'assets/images/user1.jpg'),
                      const SizedBox(height: 10),
                      _buildUserCard(
                          'finnesskelvin@gmail.com', 'assets/images/user2.jpg'),
                      const SizedBox(height: 10),
                      _buildUserCard('jobkimari@gmail.com', 'assets/images/user3.jpg'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Recent Orders Section
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Recent Orders',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _buildOrderCard('Order #001', '\$120.00'),
                      const SizedBox(height: 10),
                      _buildOrderCard('Order #002', '\$75.00'),
                      const SizedBox(height: 10),
                      _buildOrderCard('Order #003', '\$200.00'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      initialDateRange: _selectedDateRange,
    );
    if (picked != null && picked != _selectedDateRange) {
      setState(() {
        _selectedDateRange = picked;
      });
    }
  }

  Widget _buildMetricCard({required String title, required String value}) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 106,
        maxHeight: 110,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserCard(String name, String imagePath) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(imagePath),
          radius: 30,
        ),
        const SizedBox(width: 10),
        Text(
          name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildOrderCard(String orderNumber, String amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          orderNumber,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          amount,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
      ],
    );
  }
}
