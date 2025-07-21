enum UserRole { student, hr, admin, finance }

class MockUser {
  final String id;
  final String name;
  final UserRole role;
  final String avatarUrl;

  MockUser({
    required this.id,
    required this.name,
    required this.role,
    required this.avatarUrl,
  });
}

final List<MockUser> mockUsers = [
  MockUser(
    id: 'stu1',
    name: 'Aarav Sharma',
    role: UserRole.student,
    avatarUrl: 'https://randomuser.me/api/portraits/men/31.jpg',
  ),
  MockUser(
    id: 'hr1',
    name: 'Priya Nair',
    role: UserRole.hr,
    avatarUrl: 'https://randomuser.me/api/portraits/women/44.jpg',
  ),
  MockUser(
    id: 'adm1',
    name: 'Rohan Mehta',
    role: UserRole.admin,
    avatarUrl: 'https://randomuser.me/api/portraits/men/45.jpg',
  ),
  MockUser(
    id: 'fin1',
    name: 'Sneha Patel',
    role: UserRole.finance,
    avatarUrl: 'https://randomuser.me/api/portraits/women/32.jpg',
  ),
]; 