import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth_mock_data.dart';
import 'auth_provider.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login - Select Role')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text(
            'Select a user to login:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          ...mockUsers.map((user) => Card(
                child: ListTile(
                  leading: CircleAvatar(backgroundImage: NetworkImage(user.avatarUrl)),
                  title: Text(user.name),
                  subtitle: Text(user.role.name.toUpperCase()),
                  onTap: () {
                    Provider.of<AuthProvider>(context, listen: false).login(user);
                    if (user.role == UserRole.student) {
                      GoRouter.of(context).go('/dashboard/student');
                    }
                  },
                ),
              )),
        ],
      ),
    );
  }
} 