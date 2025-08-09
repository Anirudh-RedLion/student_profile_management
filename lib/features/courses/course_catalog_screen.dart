import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../shared/models/course.dart';
import 'course_detail_screen.dart';
import 'my_courses_screen.dart';
import '../../core/router.dart';

class CourseCatalogScreen extends StatefulWidget {
  const CourseCatalogScreen({super.key});

  @override
  State<CourseCatalogScreen> createState() => _CourseCatalogScreenState();
}

class _CourseCatalogScreenState extends State<CourseCatalogScreen> {
  List<Course> _courses = [];
  List<Course> _filtered = [];
  bool _loading = true;
  String _query = '';
  final Set<String> _enrolledCourseIds = {};

  @override
  void initState() {
    super.initState();
    _loadCourses();
  }

  Future<void> _loadCourses() async {
    setState(() => _loading = true);
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    final data = await rootBundle.loadString('assets/assets/data/courses.json');
    final List<dynamic> jsonList = json.decode(data);
    _courses = jsonList.map((e) => Course.fromJson(e)).toList();
    _filtered = _courses;
    setState(() => _loading = false);
  }

  void _search(String query) {
    setState(() {
      _query = query;
      _filtered = _courses.where((c) => c.title.toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Catalog'),
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search courses',
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
                    itemBuilder: (context, i) => const _CourseSkeleton(),
                  )
                : _filtered.isEmpty
                    ? const Center(child: Text('No courses found.'))
                    : ListView.builder(
                        itemCount: _filtered.length,
                        itemBuilder: (context, i) => _CourseCard(
                          course: _filtered[i],
                          enrolled: _enrolledCourseIds.contains(_filtered[i].id),
                          onTap: () async {
                            final enrolled = _enrolledCourseIds.contains(_filtered[i].id);
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => CourseDetailScreen(
                                  course: _filtered[i],
                                  enrolled: enrolled,
                                  onEnroll: enrolled
                                      ? null
                                      : () {
                                          setState(() {
                                            _enrolledCourseIds.add(_filtered[i].id);
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
      floatingActionButton: _enrolledCourseIds.isNotEmpty
          ? FloatingActionButton.extended(
              icon: const Icon(Icons.list_alt),
              label: const Text('My Courses'),
              onPressed: () {
                final myCourses = _courses.where((c) => _enrolledCourseIds.contains(c.id)).toList();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => MyCoursesScreen(enrolledCourses: myCourses),
                  ),
                );
              },
            )
          : null,
    );
  }
}

class _CourseCard extends StatelessWidget {
  final Course course;
  final bool enrolled;
  final VoidCallback onTap;
  const _CourseCard({required this.course, required this.enrolled, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        title: Text(course.title),
        subtitle: Text('${course.instructor} • ${course.domain}'),
        trailing: SizedBox(
          width: 60,
          child: LinearProgressIndicator(
            value: course.progress,
            minHeight: 8,
          ),
        ),
        onTap: onTap,
        leading: enrolled ? const Icon(Icons.check_circle, color: Colors.green) : null,
      ),
    );
  }
}

class _CourseSkeleton extends StatelessWidget {
  const _CourseSkeleton();
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        title: Container(height: 16, width: 100, color: Colors.grey.shade300),
        subtitle: Container(height: 12, width: 60, color: Colors.grey.shade200),
        trailing: Container(height: 8, width: 60, color: Colors.grey.shade200),
      ),
    );
  }
} 