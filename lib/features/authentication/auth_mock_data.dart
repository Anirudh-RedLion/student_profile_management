enum UserRole { student, hr, admin, finance }

enum AccountStatus { pending, active, suspended, inactive }

class MockUser {
  final String id;
  final String name;
  final UserRole role;
  final String avatarUrl;
  final String studentId;
  final String department;
  final int yearOfStudy;
  final List<String> skills;
  final String bio;
  final String phone;
  final String email;
  final String password; // For authentication
  final AccountStatus accountStatus;
  final bool isEmailVerified;
  final bool isPhoneVerified;
  final DateTime createdAt;
  final DateTime? lastLoginAt;

  MockUser({
    required this.id,
    required this.name,
    required this.role,
    required this.avatarUrl,
    this.studentId = '',
    this.department = '',
    this.yearOfStudy = 1,
    this.skills = const [],
    this.bio = '',
    this.phone = '',
    this.email = '',
    this.password = '',
    this.accountStatus = AccountStatus.pending,
    this.isEmailVerified = false,
    this.isPhoneVerified = false,
    DateTime? createdAt,
    this.lastLoginAt,
  }) : createdAt = createdAt ?? DateTime.now();

  MockUser copyWith({
    String? id,
    String? name,
    UserRole? role,
    String? avatarUrl,
    String? studentId,
    String? department,
    int? yearOfStudy,
    List<String>? skills,
    String? bio,
    String? phone,
    String? email,
    String? password,
    AccountStatus? accountStatus,
    bool? isEmailVerified,
    bool? isPhoneVerified,
    DateTime? createdAt,
    DateTime? lastLoginAt,
  }) {
    return MockUser(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      studentId: studentId ?? this.studentId,
      department: department ?? this.department,
      yearOfStudy: yearOfStudy ?? this.yearOfStudy,
      skills: skills ?? this.skills,
      bio: bio ?? this.bio,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      password: password ?? this.password,
      accountStatus: accountStatus ?? this.accountStatus,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      isPhoneVerified: isPhoneVerified ?? this.isPhoneVerified,
      createdAt: createdAt ?? this.createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
    );
  }

  // Helper method to check if account is fully verified and active
  bool get isAccountActive => 
      accountStatus == AccountStatus.active && 
      isEmailVerified && 
      isPhoneVerified;

  // Helper method to generate student ID based on email and department
  String generateStudentId() {
    if (role != UserRole.student) return '';
    final year = DateTime.now().year;
    final emailPrefix = email.split('@')[0].toUpperCase();
    final deptCode = department.isNotEmpty 
        ? department.split(' ').map((e) => e[0]).join('').toUpperCase()
        : 'GEN';
    return 'STU$year$deptCode${id.padLeft(3, '0')}';
  }
}

final List<MockUser> mockUsers = [
  MockUser(
    id: 'stu1',
    name: 'Aarav Sharma',
    role: UserRole.student,
    avatarUrl: 'https://ui-avatars.com/api/?name=Aarav+Sharma&background=random&color=fff&size=200',
    studentId: 'STU2024001',
    department: 'Computer Science',
    yearOfStudy: 3,
    skills: ['Flutter', 'Dart', 'Python', 'Machine Learning'],
    bio: 'Passionate about mobile development and AI. Currently working on building innovative apps.',
    phone: '+91 98765 43210',
    email: 'aarav.sharma@example.com',
    password: 'password123',
    accountStatus: AccountStatus.active,
    isEmailVerified: true,
    isPhoneVerified: true,
  ),
  MockUser(
    id: 'stu2',
    name: 'Zara Khan',
    role: UserRole.student,
    avatarUrl: 'https://ui-avatars.com/api/?name=Zara+Khan&background=random&color=fff&size=200',
    studentId: 'STU2024002',
    department: 'Electrical Engineering',
    yearOfStudy: 2,
    skills: ['Arduino', 'C++', 'Circuit Design', 'IoT'],
    bio: 'Interested in embedded systems and IoT. Love working with hardware and software integration.',
    phone: '+91 98765 43220',
    email: 'zara.khan@example.com',
    password: 'password123',
    accountStatus: AccountStatus.pending,
    isEmailVerified: false,
    isPhoneVerified: false,
  ),
  MockUser(
    id: 'stu3',
    name: 'Vikram Singh',
    role: UserRole.student,
    avatarUrl: 'https://ui-avatars.com/api/?name=Vikram+Singh&background=random&color=fff&size=200',
    studentId: 'STU2024003',
    department: 'Mechanical Engineering',
    yearOfStudy: 4,
    skills: ['AutoCAD', 'SolidWorks', '3D Modeling', 'Manufacturing'],
    bio: 'Final year mechanical engineering student. Passionate about design and manufacturing processes.',
    phone: '+91 98765 43230',
    email: 'vikram.singh@example.com',
    password: 'password123',
    accountStatus: AccountStatus.active,
    isEmailVerified: true,
    isPhoneVerified: true,
  ),
  MockUser(
    id: 'hr1',
    name: 'Priya Nair',
    role: UserRole.hr,
    avatarUrl: 'https://ui-avatars.com/api/?name=Priya+Nair&background=random&color=fff&size=200',
    phone: '+91 98765 43211',
    email: 'priya.nair@example.com',
    password: 'password123',
    accountStatus: AccountStatus.active,
    isEmailVerified: true,
    isPhoneVerified: true,
  ),
  MockUser(
    id: 'adm1',
    name: 'Rohan Mehta',
    role: UserRole.admin,
    avatarUrl: 'https://ui-avatars.com/api/?name=Rohan+Mehta&background=random&color=fff&size=200',
    phone: '+91 98765 43212',
    email: 'rohan.mehta@example.com',
    password: 'password123',
    accountStatus: AccountStatus.active,
    isEmailVerified: true,
    isPhoneVerified: true,
  ),
  MockUser(
    id: 'fin1',
    name: 'Sneha Patel',
    role: UserRole.finance,
    avatarUrl: 'https://ui-avatars.com/api/?name=Sneha+Patel&background=random&color=fff&size=200',
    phone: '+91 98765 43213',
    email: 'sneha.patel@example.com',
    password: 'password123',
    accountStatus: AccountStatus.active,
    isEmailVerified: true,
    isPhoneVerified: true,
  ),
]; 