import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../authentication/auth_provider.dart';
import '../authentication/auth_mock_data.dart';
import '../../core/router.dart';

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
  late String _studentId;
  late String _department;
  late int _yearOfStudy;
  late List<String> _skills;
  late String _bio;

  @override
  void initState() {
    super.initState();
    final user = Provider.of<AuthProvider>(context, listen: false).currentUser!;
    _name = user.name;
    _email = user.email.isNotEmpty ? user.email : '${user.name.toLowerCase().replaceAll(' ', '.')}@example.com';
    _phone = user.phone.isNotEmpty ? user.phone : '+91 98765 43210';
    _avatarUrl = user.avatarUrl;
    _studentId = user.studentId;
    _department = user.department;
    _yearOfStudy = user.yearOfStudy;
    _skills = List.from(user.skills);
    _bio = user.bio;
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
        studentId: _studentId,
        department: _department,
        yearOfStudy: _yearOfStudy,
        skills: _skills,
        bio: _bio,
        phone: _phone,
        email: _email,
      ));
      Navigator.of(context).pop();
    }
  }

  void _pickAvatar() async {
    // Simulate avatar upload by generating a new avatar with the current name
    setState(() {
      // Generate a new avatar with random background color
      final randomColors = ['FF6B6B', '4ECDC4', '45B7D1', '96CEB4', 'FFEAA7', 'DDA0DD', '98D8C8', 'F7DC6F'];
      final randomColor = randomColors[DateTime.now().millisecond % randomColors.length];
      _avatarUrl = 'https://ui-avatars.com/api/?name=${Uri.encodeComponent(_name)}&background=$randomColor&color=fff&size=200';
    });
  }

  void _addSkill() {
    final TextEditingController skillController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Skill'),
        content: TextField(
          controller: skillController,
          autofocus: true,
          decoration: const InputDecoration(
            labelText: 'Skill',
            hintText: 'e.g., Flutter, Python',
          ),
          onSubmitted: (value) {
            if (value.trim().isNotEmpty) {
              setState(() {
                _skills.add(value.trim());
              });
              Navigator.of(context).pop();
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final value = skillController.text.trim();
              if (value.isNotEmpty) {
                setState(() {
                  _skills.add(value);
                });
              }
              Navigator.of(context).pop();
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _removeSkill(int index) {
    setState(() {
      _skills.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
              appBar: AppBar(
          title: const Text('Edit Profile'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => safePop(context, fallbackRoute: '/profile'),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () => context.go('/'),
            ),
          ],
        ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Center(
                child: GestureDetector(
                  onTap: _pickAvatar,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 48,
                        backgroundColor: Colors.grey[300],
                        child: ClipOval(
                          child: Image.network(
                            _avatarUrl,
                            width: 96,
                            height: 96,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              // Fallback to initials if image fails to load
                              return Container(
                                width: 96,
                                height: 96,
                                decoration: BoxDecoration(
                                  color: Colors.blue[400],
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    _name.split(' ').map((e) => e[0]).join('').toUpperCase(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
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
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _phone,
                decoration: const InputDecoration(labelText: 'Phone'),
                validator: (v) => v == null || v.length < 10 ? 'Valid phone required' : null,
                onSaved: (v) => _phone = v!,
              ),
                            // Student-specific fields (only show for students)
              if (Provider.of<AuthProvider>(context, listen: false).currentUser!.role == UserRole.student) ...[
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: _studentId,
                  decoration: const InputDecoration(labelText: 'Student ID'),
                  validator: (v) => v == null || v.isEmpty ? 'Student ID required' : null,
                  onSaved: (v) => _studentId = v!,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: _department,
                  decoration: const InputDecoration(labelText: 'Department'),
                  validator: (v) => v == null || v.isEmpty ? 'Department required' : null,
                  onSaved: (v) => _department = v!,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: _yearOfStudy.toString(),
                  decoration: const InputDecoration(labelText: 'Year of Study'),
                  validator: (v) => v == null || int.tryParse(v) == null || int.parse(v) < 1 || int.parse(v) > 5 ? 'Valid year required (1-5)' : null,
                  onSaved: (v) => _yearOfStudy = int.parse(v!),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text('Skills', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                    const Spacer(),
                    IconButton(
                      onPressed: _addSkill,
                      icon: const Icon(Icons.add),
                      tooltip: 'Add Skill',
                    ),
                  ],
                ),
                if (_skills.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: List<Widget>.generate(_skills.length, (index) {
                      return InputChip(
                        label: Text(_skills[index]),
                        onDeleted: () => _removeSkill(index),
                      );
                    }),
                  ),
                ],
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: _bio,
                  decoration: const InputDecoration(labelText: 'Bio'),
                  validator: (v) => v == null || v.length < 10 ? 'Bio must be at least 10 characters' : null,
                  onSaved: (v) => _bio = v!,
                  maxLines: 3,
                ),
              ],
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