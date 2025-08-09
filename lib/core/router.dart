import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../features/authentication/auth_provider.dart';
import '../features/authentication/login_screen.dart';
import '../features/authentication/auth_mock_data.dart';
import '../features/dashboard/student_dashboard_screen.dart';
import '../features/dashboard/hr_dashboard_screen.dart';
import '../features/dashboard/admin_dashboard_screen.dart';
import '../features/dashboard/finance_dashboard_screen.dart';
import '../features/profile/profile_screen.dart';
import '../features/courses/course_catalog_screen.dart';
import '../features/jobs/job_listings_screen.dart';
import '../features/queries/query_list_screen.dart';

// Utility function for safe navigation back
void safePop(BuildContext context, {String? fallbackRoute}) {
  if (context.canPop()) {
    context.pop();
  } else if (fallbackRoute != null) {
    context.go(fallbackRoute);
  } else {
    context.go('/');
  }
}

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
          switch (auth.currentRole) {
            case UserRole.student:
              return const StudentDashboardScreen();
            case UserRole.hr:
              return const HRDashboardScreen();
            case UserRole.admin:
              return const AdminDashboardScreen();
            case UserRole.finance:
              return const FinanceDashboardScreen();
            default:
              return const Placeholder();
          }
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
      GoRoute(
        path: '/courses',
        builder: (context, state) {
          final auth = Provider.of<AuthProvider>(context);
          if (!auth.isLoggedIn) {
            return const LoginScreen();
          }
          return const CourseCatalogScreen();
        },
      ),
      GoRoute(
        path: '/jobs',
        builder: (context, state) {
          final auth = Provider.of<AuthProvider>(context);
          if (!auth.isLoggedIn) {
            return const LoginScreen();
          }
          return const JobListingsScreen();
        },
      ),
      GoRoute(
        path: '/queries',
        builder: (context, state) {
          final auth = Provider.of<AuthProvider>(context);
          if (!auth.isLoggedIn) {
            return const LoginScreen();
          }
          return const QueryListScreen();
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