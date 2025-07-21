import 'package:flutter/material.dart';

class FinanceDashboardScreen extends StatelessWidget {
  const FinanceDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Finance Dashboard')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: const [
          Text('Welcome, Finance!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 24),
          Card(child: ListTile(title: Text('Revenue Overview (Placeholder)'))),
          SizedBox(height: 16),
          Card(child: ListTile(title: Text('Payment Tracking (Placeholder)'))),
          SizedBox(height: 16),
          Card(child: ListTile(title: Text('Invoice Management (Placeholder)'))),
          SizedBox(height: 16),
          Card(child: ListTile(title: Text('Financial Reports (Placeholder)'))),
        ],
      ),
    );
  }
} 