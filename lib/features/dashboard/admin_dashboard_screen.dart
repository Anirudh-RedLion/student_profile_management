import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../shared/models/course.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  List<Course> _courses = [];
  bool _loading = true;
  final List<Map<String, String>> _users = [
    {'name': 'Aarav Sharma', 'role': 'student'},
    {'name': 'Priya Nair', 'role': 'hr'},
    {'name': 'Rohan Mehta', 'role': 'admin'},
    {'name': 'Sneha Patel', 'role': 'finance'},
  ];
  final List<String> _auditLogs = [
    'User Aarav Sharma enrolled in Flutter Basics',
    'Priya Nair responded to a query',
    'Course AI & Machine Learning approved',
    'System health check passed',
  ];

  @override
  void initState() {
    super.initState();
    _loadCourses();
  }

  Future<void> _loadCourses() async {
    setState(() => _loading = true);
    await Future.delayed(const Duration(seconds: 1));
    final data = await rootBundle.loadString('assets/assets/data/courses.json');
    final List<dynamic> jsonList = json.decode(data);
    _courses = jsonList.map((e) => Course.fromJson(e)).toList();
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
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
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(24),
              children: [
                const Text('Welcome, Admin!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 24),
                const Text('System Health', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Card(child: ListTile(title: Text('Uptime: 99.99%'), subtitle: Text('No critical errors.'))),
                const SizedBox(height: 24),
                const Text('User Management', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                ..._users.map((u) => Card(
                      child: ListTile(
                        title: Text(u['name']!),
                        subtitle: Text('Role: ${u['role']}'),
                        trailing: DropdownButton<String>(
                          value: u['role'],
                          items: const [
                            DropdownMenuItem(value: 'student', child: Text('Student')),
                            DropdownMenuItem(value: 'hr', child: Text('HR')),
                            DropdownMenuItem(value: 'admin', child: Text('Admin')),
                            DropdownMenuItem(value: 'finance', child: Text('Finance')),
                          ],
                          onChanged: (v) {}, // mock
                        ),
                      ),
                    )),
                const SizedBox(height: 24),
                const Text('Course Administration', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                ..._courses.take(5).map((c) => Card(
                      child: ListTile(
                        title: Text(c.title),
                        subtitle: Text('Instructor: ${c.instructor}'),
                        trailing: ElevatedButton(
                          onPressed: () {},
                          child: const Text('Approve'),
                        ),
                      ),
                    )),
                const SizedBox(height: 24),
                const Text('Audit Logs', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                ..._auditLogs.map((log) => Card(child: ListTile(title: Text(log)))),
              ],
            ),
    );
  }
} 