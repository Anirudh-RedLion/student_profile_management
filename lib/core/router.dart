import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../features/authentication/auth_provider.dart';
import '../features/authentication/login_screen.dart';
import '../features/authentication/auth_mock_data.dart';
import '../features/dashboard/student_dashboard_screen.dart';
import '../features/profile/profile_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          final auth = Provider.of<AuthProvider>(context);
          if (!auth.isLoggedIn) {
            return const LoginScreen();
          }
          return const PlaceholderDashboard();
        },
      ),
      GoRoute(
        path: '/dashboard/student',
        builder: (context, state) {
          final auth = Provider.of<AuthProvider>(context);
          if (!auth.isLoggedIn || auth.currentRole != UserRole.student) {
            return const LoginScreen();
          }
          return const StudentDashboardScreen();
        },
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) {
          final auth = Provider.of<AuthProvider>(context);
          if (!auth.isLoggedIn) {
            return const LoginScreen();
          }
          return const ProfileScreen();
        },
      ),
    ],
  );
}

class PlaceholderDashboard extends StatelessWidget {
  const PlaceholderDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).currentUser;
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard - ${user?.role.name.toUpperCase()}')),
      body: Center(child: Text('Welcome, ${user?.name ?? ''}!')), 
    );
  }
} 