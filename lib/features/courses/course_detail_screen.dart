import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../shared/models/course.dart';
import '../../core/router.dart';

class CourseDetailScreen extends StatelessWidget {
  final Course course;
  final bool enrolled;
  final VoidCallback? onEnroll;
  const CourseDetailScreen({super.key, required this.course, this.enrolled = false, this.onEnroll});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
              appBar: AppBar(
          title: Text(course.title),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => safePop(context),
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
          Text(course.title, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 8),
          Text('Instructor: ${course.instructor}', style: const TextStyle(color: Colors.grey)),
          Text('Domain: ${course.domain}', style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 16),
          Text(course.description),
          const SizedBox(height: 24),
          Text('Materials', style: Theme.of(context).textTheme.titleMedium),
          ...course.materials.map((m) => ListTile(
                leading: const Icon(Icons.file_present),
                title: Text(m),
              )),
          const SizedBox(height: 24),
          Text('Progress', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          LinearProgressIndicator(value: course.progress, minHeight: 12),
          const SizedBox(height: 24),
          enrolled
              ? ElevatedButton.icon(
                  onPressed: null,
                  icon: const Icon(Icons.check),
                  label: const Text('Enrolled'),
                )
              : ElevatedButton.icon(
                  onPressed: onEnroll,
                  icon: const Icon(Icons.school),
                  label: const Text('Enroll'),
                ),
        ],
      ),
    );
  }
} 