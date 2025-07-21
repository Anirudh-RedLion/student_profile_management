import 'package:flutter/material.dart';
import '../../shared/models/job.dart';

class JobDetailScreen extends StatelessWidget {
  final Job job;
  final bool applied;
  final VoidCallback? onApply;
  const JobDetailScreen({super.key, required this.job, this.applied = false, this.onApply});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(job.title)),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(job.title, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 8),
          Text('Company: ${job.company}', style: const TextStyle(color: Colors.grey)),
          Text('Location: ${job.location}', style: const TextStyle(color: Colors.grey)),
          Text('Salary: ${job.salary}', style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 16),
          Text(job.description),
          const SizedBox(height: 24),
          Text('Requirements', style: Theme.of(context).textTheme.titleMedium),
          ...job.requirements.map((r) => ListTile(
                leading: const Icon(Icons.check),
                title: Text(r),
              )),
          const SizedBox(height: 24),
          Text('Status: ${job.status.toUpperCase()}', style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          applied
              ? ElevatedButton.icon(
                  onPressed: null,
                  icon: const Icon(Icons.check),
                  label: const Text('Applied'),
                )
              : ElevatedButton.icon(
                  onPressed: onApply,
                  icon: const Icon(Icons.send),
                  label: const Text('Apply'),
                ),
        ],
      ),
    );
  }
} 