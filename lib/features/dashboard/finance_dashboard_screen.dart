import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FinanceDashboardScreen extends StatelessWidget {
  const FinanceDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final payments = [
      {'student': 'Aarav Sharma', 'status': 'Paid', 'amount': '₹50,000'},
      {'student': 'Priya Nair', 'status': 'Unpaid', 'amount': '₹48,000'},
      {'student': 'Rohan Mehta', 'status': 'Paid', 'amount': '₹52,000'},
    ];
    final invoices = [
      {'id': 'INV001', 'student': 'Aarav Sharma', 'amount': '₹50,000'},
      {'id': 'INV002', 'student': 'Priya Nair', 'amount': '₹48,000'},
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finance Dashboard'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Check if we can pop, if not go to home
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/');
            }
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () => context.go('/'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text('Welcome, Finance!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          const Text('Revenue Overview', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Card(child: ListTile(title: Text('Total Revenue: ₹1,50,000 (static)'), subtitle: Text('Trend: +5% this month'))),
          const SizedBox(height: 24),
          const Text('Payment Tracking', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ...payments.map((p) => Card(
                child: ListTile(
                  title: Text(p['student']!),
                  subtitle: Text('Amount: ${p['amount']}'),
                  trailing: Chip(label: Text(p['status']!)),
                ),
              )),
          const SizedBox(height: 24),
          const Text('Invoice Management', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ...invoices.map((inv) => Card(
                child: ListTile(
                  title: Text('Invoice: ${inv['id']}'),
                  subtitle: Text('Student: ${inv['student']}'),
                  trailing: Text(inv['amount']!),
                ),
              )),
          const SizedBox(height: 24),
          const Text('Financial Reports', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              title: const Text('Download Financial Report (mock)'),
              trailing: IconButton(
                icon: const Icon(Icons.download),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Report download simulated.')));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
} 