import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../features/authentication/auth_provider.dart';
import 'package:go_router/go_router.dart';

class StudentDashboardScreen extends StatelessWidget {
  const StudentDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            tooltip: 'My Profile',
            onPressed: () {
              GoRouter.of(context).go('/profile');
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Welcome, ${user?.name ?? ''}!', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 16),
          // Stats cards
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              _StatCard(label: 'Courses', value: '4'),
              _StatCard(label: 'Jobs', value: '2'),
              _StatCard(label: 'Queries', value: '1'),
            ],
          ),
          const SizedBox(height: 24),
          // Quick actions
          const Text('Quick Actions', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              _QuickAction(icon: Icons.book, label: 'Browse Courses'),
              _QuickAction(icon: Icons.work, label: 'Apply Jobs'),
              _QuickAction(icon: Icons.help, label: 'Ask Question'),
            ],
          ),
          const SizedBox(height: 24),
          // Recent activity
          const Text('Recent Activity', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ...[
            _ActivityItem(icon: Icons.book, text: 'Enrolled in Flutter Basics', time: '2h ago'),
            _ActivityItem(icon: Icons.work, text: 'Applied to TCS Internship', time: '1d ago'),
            _ActivityItem(icon: Icons.help, text: 'Asked about course credits', time: '3d ago'),
          ],
          const SizedBox(height: 24),
          // Progress tracking
          const Text('Progress', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              _ProgressCircle(label: 'Flutter', percent: 0.7),
              _ProgressCircle(label: 'DSA', percent: 0.5),
              _ProgressCircle(label: 'AI', percent: 0.3),
            ],
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

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  const _QuickAction({required this.icon, required this.label});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (label == 'Browse Courses') {
          GoRouter.of(context).go('/courses');
        }
      },
      child: Column(
        children: [
          CircleAvatar(child: Icon(icon)),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

class _ActivityItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final String time;
  const _ActivityItem({required this.icon, required this.text, required this.time});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      trailing: Text(time, style: const TextStyle(fontSize: 12)),
    );
  }
}

class _ProgressCircle extends StatelessWidget {
  final String label;
  final double percent;
  const _ProgressCircle({required this.label, required this.percent});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 56,
              height: 56,
              child: CircularProgressIndicator(
                value: percent,
                strokeWidth: 6,
              ),
            ),
            Text('${(percent * 100).toInt()}%', style: const TextStyle(fontSize: 12)),
          ],
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
} 