import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../shared/models/job.dart';
import 'job_detail_screen.dart';

class JobListingsScreen extends StatefulWidget {
  const JobListingsScreen({super.key});

  @override
  State<JobListingsScreen> createState() => _JobListingsScreenState();
}

class _JobListingsScreenState extends State<JobListingsScreen> {
  List<Job> _jobs = [];
  List<Job> _filtered = [];
  bool _loading = true;
  String _query = '';
  final Set<String> _appliedJobIds = {};

  @override
  void initState() {
    super.initState();
    _loadJobs();
  }

  Future<void> _loadJobs() async {
    setState(() => _loading = true);
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    final data = await rootBundle.loadString('assets/data/jobs.json');
    final List<dynamic> jsonList = json.decode(data);
    _jobs = jsonList.map((e) => Job.fromJson(e)).toList();
    _filtered = _jobs;
    setState(() => _loading = false);
  }

  void _search(String query) {
    setState(() {
      _query = query;
      _filtered = _jobs.where((j) => j.title.toLowerCase().contains(query.toLowerCase()) || j.company.toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Job Listings')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search jobs',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: _search,
            ),
          ),
          Expanded(
            child: _loading
                ? ListView.builder(
                    itemCount: 6,
                    itemBuilder: (context, i) => const _JobSkeleton(),
                  )
                : _filtered.isEmpty
                    ? const Center(child: Text('No jobs found.'))
                    : ListView.builder(
                        itemCount: _filtered.length,
                        itemBuilder: (context, i) => _JobCard(
                          job: _filtered[i],
                          applied: _appliedJobIds.contains(_filtered[i].id),
                          onTap: () async {
                            final applied = _appliedJobIds.contains(_filtered[i].id);
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => JobDetailScreen(
                                  job: _filtered[i],
                                  applied: applied,
                                  onApply: applied
                                      ? null
                                      : () {
                                          setState(() {
                                            _appliedJobIds.add(_filtered[i].id);
                                          });
                                          Navigator.of(context).pop();
                                        },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}

class _JobCard extends StatelessWidget {
  final Job job;
  final bool applied;
  final VoidCallback onTap;
  const _JobCard({required this.job, required this.applied, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        title: Text(job.title),
        subtitle: Text('${job.company} • ${job.location}'),
        trailing: Text(job.salary, style: const TextStyle(fontWeight: FontWeight.bold)),
        onTap: onTap,
        leading: applied ? const Icon(Icons.check_circle, color: Colors.green) : null,
      ),
    );
  }
}

class _JobSkeleton extends StatelessWidget {
  const _JobSkeleton();
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        title: Container(height: 16, width: 100, color: Colors.grey.shade300),
        subtitle: Container(height: 12, width: 60, color: Colors.grey.shade200),
        trailing: Container(height: 16, width: 40, color: Colors.grey.shade200),
      ),
    );
  }
} 