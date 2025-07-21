# Student Profile Management App

## Implementation Timeline (Sequential)

1. **Project Initialization**
   - Flutter project created with feature-first architecture
   - Documentation and assets folders initialized
   - Git repository initialized
2. **Dependency Setup**
   - All required dependencies added to `pubspec.yaml`
   - Ensured compatibility and resolved version issues
3. **Core Theme & Routing**
   - Material 3 theme system with Google Fonts (Poppins)
   - Role-based color schemes scaffolded
   - GoRouter set up for navigation
4. **Feature-First Folder Structure**
   - `lib/` organized into `core/`, `shared/`, and `features/` modules
5. **Authentication Module**
   - Mock login with role selection (Student, HR, Admin, Finance)
   - Session management using Provider
   - Route guards for protected access
6. **Student Dashboard**
   - Personalized greeting
   - Stats cards (courses, jobs, queries)
   - Quick actions
   - Recent activity timeline
   - Progress tracking indicators
   - Role-based access (only students)

---

## Project Overview
A comprehensive cross-platform Flutter application for educational institutions to manage student profiles, course enrollments, job applications, and support queries with role-based access control and a stunning Material 3 UI.

## Initial Setup (Phase 1)
- Project created with Flutter 3.24+
- Feature-first architecture planned
- Documentation and assets folders initialized
- All required dependencies added to `pubspec.yaml`
- Git repository initialized

## Progress Update (Feature-First Structure)
- Full feature-first folder structure scaffolded in `lib/`:
  - core/
  - shared/widgets, shared/models, shared/services
  - features/authentication, dashboard, profile, courses, jobs, queries

## Progress Update (Authentication Module)
- Mock authentication implemented with role selection
- Session management using Provider
- Route guards: login required to access dashboard
- Dashboard displays user name and role after login

## Progress Update (Student Dashboard)
- Student dashboard implemented with:
  - Personalized greeting
  - Stats cards (courses, jobs, queries)
  - Quick actions
  - Recent activity timeline
  - Progress tracking indicators
- Only accessible to users with the Student role

## Progress Update (Profile Management)
- Profile screen displays avatar, name, role, contact info, and resume download
- Edit Profile button opens a form for updating name and avatar (simulated upload)
- Changes are reflected immediately (mock data)
- Profile is accessible from the dashboard via the profile icon

## Progress Update (My Courses)
- Students can view all enrolled courses in a dedicated My Courses screen
- Progress indicators and navigation to course details included
- Access My Courses from the floating button in the course catalog

## How to View the New Structure
- Run the app as before:
  - `flutter run` (mobile)
  - `flutter run -d chrome` (web)
- You should see a simple home screen with the app bar: 'Student PM App' and a welcome message.

## How to Run the App Locally

### Mobile (Android/iOS)
```
flutter run
```

### Web
```
flutter run -d chrome
```

- The app will open with the default Flutter counter screen. Custom features will be added in subsequent phases.

## How to Test Authentication
- Run the app
- Select a user/role on the login screen
- You will be taken to a dashboard with your name and role
- Refresh or restart to test session reset

## How to Test Student Dashboard
- Log in as a Student
- You will be redirected to the Student Dashboard
- Explore the stats, quick actions, activity, and progress sections

## How to Test Profile Management
- Log in as a student
- Click the profile icon in the dashboard app bar
- View your profile details
- Click Edit Profile, update your name or avatar, and save
- See the changes reflected on your profile

## How to Test My Courses
- Enroll in one or more courses from the catalog
- Click the 'My Courses' floating button
- View your enrolled courses and progress
- Tap a course to see its details

## Next Steps
- Scaffold feature-first folder structure in `lib/`
- Implement core theme system and routing
- Add authentication module

---
_This README will be updated after each major phase and sub-task._
