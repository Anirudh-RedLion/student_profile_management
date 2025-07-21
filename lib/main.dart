import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/themes.dart';
import 'core/router.dart';
import 'features/authentication/auth_provider.dart';

void main() {
  runApp(const StudentPMApp());
}

class StudentPMApp extends StatelessWidget {
  const StudentPMApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, auth, child) {
          final role = auth.currentRole;
          return MaterialApp.router(
            title: 'Student Profile Management',
            theme: AppThemes.light(role: role),
            darkTheme: AppThemes.dark(role: role),
            themeMode: ThemeMode.system,
            routerConfig: AppRouter.router,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
