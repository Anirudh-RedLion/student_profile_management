import 'package:flutter/material.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Dashboard')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: const [
          Text('Welcome, Admin!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 24),
          Card(child: ListTile(title: Text('System Health (Placeholder)'))),
          SizedBox(height: 16),
          Card(child: ListTile(title: Text('User Management (Placeholder)'))),
          SizedBox(height: 16),
          Card(child: ListTile(title: Text('Course Administration (Placeholder)'))),
          SizedBox(height: 16),
          Card(child: ListTile(title: Text('Audit Logs (Placeholder)'))),
        ],
      ),
    );
  }
} 