import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../authentication/auth_provider.dart';
import '../authentication/auth_mock_data.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _email;
  late String _phone;
  late String _avatarUrl;

  @override
  void initState() {
    super.initState();
    final user = Provider.of<AuthProvider>(context, listen: false).currentUser!;
    _name = user.name;
    _email = user.name.toLowerCase().replaceAll(' ', '.') + '@example.com';
    _phone = '+91 98765 43210';
    _avatarUrl = user.avatarUrl;
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final auth = Provider.of<AuthProvider>(context, listen: false);
      final user = auth.currentUser!;
      // Update the user in memory (mock)
      auth.login(MockUser(
        id: user.id,
        name: _name,
        role: user.role,
        avatarUrl: _avatarUrl,
      ));
      Navigator.of(context).pop();
    }
  }

  void _pickAvatar() async {
    // Simulate avatar upload by toggling between two images
    setState(() {
      _avatarUrl = _avatarUrl.contains('men')
          ? 'https://randomuser.me/api/portraits/women/31.jpg'
          : 'https://randomuser.me/api/portraits/men/31.jpg';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Center(
                child: GestureDetector(
                  onTap: _pickAvatar,
                  child: CircleAvatar(
                    radius: 48,
                    backgroundImage: NetworkImage(_avatarUrl),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _name,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (v) => v == null || v.isEmpty ? 'Name required' : null,
                onSaved: (v) => _name = v!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _email,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (v) => v == null || !v.contains('@') ? 'Valid email required' : null,
                onSaved: (v) => _email = v!,
                enabled: false, // Email is not editable in this mock
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _phone,
                decoration: const InputDecoration(labelText: 'Phone'),
                validator: (v) => v == null || v.length < 10 ? 'Valid phone required' : null,
                onSaved: (v) => _phone = v!,
                enabled: false, // Phone is not editable in this mock
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: _save,
                icon: const Icon(Icons.save),
                label: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 