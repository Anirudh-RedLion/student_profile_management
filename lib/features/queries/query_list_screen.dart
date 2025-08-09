import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../shared/models/query.dart';
import 'query_detail_screen.dart';
import '../../core/router.dart';

class QueryListScreen extends StatefulWidget {
  const QueryListScreen({super.key});

  @override
  State<QueryListScreen> createState() => _QueryListScreenState();
}

class _QueryListScreenState extends State<QueryListScreen> {
  List<SupportQuery> _queries = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadQueries();
  }

  Future<void> _loadQueries() async {
    setState(() => _loading = true);
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    final data = await rootBundle.loadString('assets/assets/data/queries.json');
    final List<dynamic> jsonList = json.decode(data);
    // Only show queries for the current student (mock: 'Aarav Sharma')
    _queries = jsonList.map((e) => SupportQuery.fromJson(e)).where((q) => q.student == 'Aarav Sharma').toList();
    setState(() => _loading = false);
  }

  void _createQuery() async {
    final newQuery = await showDialog<SupportQuery>(
      context: context,
      builder: (context) => _QueryCreationDialog(student: 'Aarav Sharma'),
    );
    if (newQuery != null) {
      setState(() {
        _queries.insert(0, newQuery);
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Query submitted!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Queries'),
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
      body: _loading
          ? ListView.builder(
              itemCount: 6,
              itemBuilder: (context, i) => const _QuerySkeleton(),
            )
          : _queries.isEmpty
              ? const Center(child: Text('No queries found.'))
              : ListView.builder(
                  itemCount: _queries.length,
                  itemBuilder: (context, i) => _QueryCard(
                    query: _queries[i],
                    onTap: () async {
                      final updated = await Navigator.of(context).push<String>(
                        MaterialPageRoute(
                          builder: (_) => QueryDetailScreen(
                            query: _queries[i],
                            onAddResponse: (msg) {},
                          ),
                        ),
                      );
                      if (updated != null) setState(() {});
                    },
                  ),
                ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add_comment),
        label: const Text('Ask Question'),
        onPressed: _createQuery,
      ),
    );
  }
}

class _QueryCard extends StatelessWidget {
  final SupportQuery query;
  final VoidCallback? onTap;
  const _QueryCard({required this.query, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        title: Text(query.question),
        subtitle: Text('${query.category} • ${query.status.toUpperCase()}'),
        trailing: Chip(label: Text(query.priority)),
        onTap: onTap,
      ),
    );
  }
}

class _QuerySkeleton extends StatelessWidget {
  const _QuerySkeleton();
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

class _QueryCreationDialog extends StatefulWidget {
  final String student;
  const _QueryCreationDialog({required this.student});
  @override
  State<_QueryCreationDialog> createState() => _QueryCreationDialogState();
}

class _QueryCreationDialogState extends State<_QueryCreationDialog> {
  final _formKey = GlobalKey<FormState>();
  String _category = 'Course Enrollment';
  String _priority = 'medium';
  String _question = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Ask a Question'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              value: _category,
              items: const [
                DropdownMenuItem(value: 'Course Enrollment', child: Text('Course Enrollment')),
                DropdownMenuItem(value: 'Job Application', child: Text('Job Application')),
                DropdownMenuItem(value: 'Finance', child: Text('Finance')),
                DropdownMenuItem(value: 'Other', child: Text('Other')),
              ],
              onChanged: (v) => setState(() => _category = v!),
              decoration: const InputDecoration(labelText: 'Category'),
            ),
            DropdownButtonFormField<String>(
              value: _priority,
              items: const [
                DropdownMenuItem(value: 'high', child: Text('High')),
                DropdownMenuItem(value: 'medium', child: Text('Medium')),
                DropdownMenuItem(value: 'low', child: Text('Low')),
              ],
              onChanged: (v) => setState(() => _priority = v!),
              decoration: const InputDecoration(labelText: 'Priority'),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Your Question'),
              validator: (v) => v == null || v.isEmpty ? 'Please enter your question' : null,
              onSaved: (v) => _question = v!,
              maxLines: 2,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              Navigator.of(context).pop(
                SupportQuery(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  student: widget.student,
                  category: _category,
                  status: 'open',
                  priority: _priority,
                  question: _question,
                  responses: [],
                ),
              );
            }
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
} 