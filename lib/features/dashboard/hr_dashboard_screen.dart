import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../shared/models/job.dart';
import '../../shared/models/query.dart';

class HRDashboardScreen extends StatefulWidget {
  const HRDashboardScreen({super.key});

  @override
  State<HRDashboardScreen> createState() => _HRDashboardScreenState();
}

class _HRDashboardScreenState extends State<HRDashboardScreen> {
  List<Job> _jobs = [];
  List<SupportQuery> _queries = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _loading = true);
    await Future.wait([
      Future.delayed(const Duration(seconds: 1)),
      _loadJobs(),
      _loadQueries(),
    ]);
    setState(() => _loading = false);
  }

  Future<void> _loadJobs() async {
    final data = await rootBundle.loadString('assets/data/jobs.json');
    final List<dynamic> jsonList = json.decode(data);
    _jobs = jsonList.map((e) => Job.fromJson(e)).toList();
  }

  Future<void> _loadQueries() async {
    final data = await rootBundle.loadString('assets/data/queries.json');
    final List<dynamic> jsonList = json.decode(data);
    _queries = jsonList.map((e) => SupportQuery.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final openApps = _jobs.length;
    final openQueries = _queries.where((q) => q.status == 'open').length;
    final students = 15; // mock
    return Scaffold(
      appBar: AppBar(title: const Text('HR Dashboard')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(24),
              children: [
                const Text('Welcome, HR!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _StatCard(label: 'Applications', value: openApps.toString()),
                    _StatCard(label: 'Open Queries', value: openQueries.toString()),
                    _StatCard(label: 'Students', value: students.toString()),
                  ],
                ),
                const SizedBox(height: 24),
                const Text('Application Review', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                ..._jobs.take(5).map((job) => Card(
                      child: ListTile(
                        title: Text(job.title),
                        subtitle: Text('${job.company} • ${job.location}'),
                        trailing: Chip(label: Text(job.status)),
                      ),
                    )),
                const SizedBox(height: 24),
                const Text('Query Responses', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                ..._queries.where((q) => q.status == 'open').take(5).map((q) => Card(
                      child: ListTile(
                        title: Text(q.question),
                        subtitle: Text('${q.student} • ${q.category}'),
                        trailing: Chip(label: Text(q.priority)),
                      ),
                    )),
                const SizedBox(height: 24),
                const Text('Student Management', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Card(child: ListTile(title: const Text('Search and manage students (mock)'))),
                const SizedBox(height: 24),
                const Text('Analytics', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Card(
                  child: ListTile(
                    title: Text('Hiring Trends: ${openApps * 2} interviews scheduled (mock)'),
                  ),
                ),
              ],
            ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  const _StatCard({required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(value, style: Theme.of(context).textTheme.headlineSmall),
            Text(label),
          ],
        ),
      ),
    );
  }
} 