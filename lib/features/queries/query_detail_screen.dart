import 'package:flutter/material.dart';
import '../../shared/models/query.dart';

class QueryDetailScreen extends StatefulWidget {
  final SupportQuery query;
  final void Function(String message)? onAddResponse;
  const QueryDetailScreen({super.key, required this.query, this.onAddResponse});

  @override
  State<QueryDetailScreen> createState() => _QueryDetailScreenState();
}

class _QueryDetailScreenState extends State<QueryDetailScreen> {
  final _controller = TextEditingController();
  late List<QueryResponse> _responses;

  @override
  void initState() {
    super.initState();
    _responses = List<QueryResponse>.from(widget.query.responses);
  }

  void _addResponse() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _responses.add(QueryResponse(
          by: 'Aarav Sharma',
          message: text,
          time: DateTime.now().toString().substring(0, 16),
        ));
      });
      _controller.clear();
      if (widget.onAddResponse != null) {
        widget.onAddResponse!(text);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final q = widget.query;
    return Scaffold(
      appBar: AppBar(title: const Text('Query Details')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(q.question, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Row(
              children: [
                Chip(label: Text(q.category)),
                const SizedBox(width: 8),
                Chip(label: Text(q.status.toUpperCase())),
                const SizedBox(width: 8),
                Chip(label: Text(q.priority)),
              ],
            ),
            const SizedBox(height: 24),
            const Text('Threaded Responses:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Expanded(
              child: _responses.isEmpty
                  ? const Text('No responses yet.')
                  : ListView.builder(
                      itemCount: _responses.length,
                      itemBuilder: (context, i) => ListTile(
                        leading: CircleAvatar(child: Text(_responses[i].by[0])),
                        title: Text(_responses[i].by),
                        subtitle: Text(_responses[i].message),
                        trailing: Text(_responses[i].time, style: const TextStyle(fontSize: 10)),
                      ),
                    ),
            ),
            const Divider(),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(hintText: 'Add a response...'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _addResponse,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 