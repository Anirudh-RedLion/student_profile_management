import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../shared/models/course.dart';
import 'course_detail_screen.dart';
import '../../core/router.dart';

class MyCoursesScreen extends StatelessWidget {
  final List<Course> enrolledCourses;
  const MyCoursesScreen({super.key, required this.enrolledCourses});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Courses'),
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
      body: enrolledCourses.isEmpty
          ? const Center(child: Text('You are not enrolled in any courses.'))
          : ListView.builder(
              itemCount: enrolledCourses.length,
              itemBuilder: (context, i) => Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: ListTile(
                  title: Text(enrolledCourses[i].title),
                  subtitle: Text('Progress: ${(enrolledCourses[i].progress * 100).toInt()}%'),
                  trailing: SizedBox(
                    width: 60,
                    child: LinearProgressIndicator(
                      value: enrolledCourses[i].progress,
                      minHeight: 8,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => CourseDetailScreen(
                          course: enrolledCourses[i],
                          enrolled: true,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }
} 