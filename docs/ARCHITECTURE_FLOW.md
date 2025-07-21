# Application Architecture & Flow Diagram

This document provides a high-level overview of the Student PM App, including all user roles, Flutter screens, API endpoints (Go backend), and database tables.

## Mermaid Flow Diagram

```mermaid
flowchart TD
  subgraph Users
    Student["Student"]
    HR["HR"]
    Admin["Admin"]
    Finance["Finance"]
  end

  subgraph FlutterApp["Flutter App (Frontend)"]
    Login["Login/Role Selection"]
    StudentDash["Student Dashboard"]
    HRDash["HR Dashboard"]
    AdminDash["Admin Dashboard"]
    FinanceDash["Finance Dashboard"]
    Profile["Profile Management"]
    Courses["Course Catalog & Enrollment"]
    MyCourses["My Courses"]
    Jobs["Job Listings & Applications"]
    MyJobs["My Applications"]
    Queries["Query Portal"]
    QueryDetail["Query Detail/Thread"]
    Settings["Settings/Theme"]
  end

  subgraph API["Go REST API"]
    AuthAPI["/api/login, /api/register"]
    StudentAPI["/api/students"]
    CourseAPI["/api/courses"]
    JobAPI["/api/jobs, /api/applications"]
    QueryAPI["/api/queries"]
    AnalyticsAPI["/api/analytics"]
    FileAPI["/api/files"]
  end

  subgraph DB["Database (Postgres/MySQL)"]
    StudentsTable["students"]
    CoursesTable["courses"]
    JobsTable["jobs"]
    ApplicationsTable["applications"]
    QueriesTable["queries"]
    UsersTable["users"]
    FilesTable["files"]
    AnalyticsTable["analytics"]
  end

  Student --> Login
  HR --> Login
  Admin --> Login
  Finance --> Login

  Login -->|"POST /api/login"| AuthAPI
  StudentDash -->|"GET /api/courses"| CourseAPI
  StudentDash -->|"GET /api/jobs"| JobAPI
  StudentDash -->|"GET /api/queries"| QueryAPI
  HRDash -->|"GET /api/applications"| JobAPI
  HRDash -->|"GET /api/queries"| QueryAPI
  HRDash -->|"GET /api/analytics"| AnalyticsAPI
  AdminDash -->|"GET /api/users"| StudentAPI
  AdminDash -->|"GET /api/courses"| CourseAPI
  AdminDash -->|"GET /api/audit"| AnalyticsAPI
  FinanceDash -->|"GET /api/payments"| AnalyticsAPI
  FinanceDash -->|"GET /api/reports"| AnalyticsAPI
  Profile -->|"GET/PUT /api/students/{id}"| StudentAPI
  Courses -->|"GET /api/courses"| CourseAPI
  MyCourses -->|"GET /api/courses/enrolled"| CourseAPI
  Jobs -->|"GET /api/jobs"| JobAPI
  MyJobs -->|"GET /api/applications"| JobAPI
  Queries -->|"GET/POST /api/queries"| QueryAPI
  QueryDetail -->|"GET/POST /api/queries/{id}/responses"| QueryAPI
  Settings -->|"GET/PUT /api/users/{id}/settings"| AuthAPI

  AuthAPI --> UsersTable
  StudentAPI --> StudentsTable
  CourseAPI --> CoursesTable
  JobAPI --> JobsTable
  JobAPI --> ApplicationsTable
  QueryAPI --> QueriesTable
  AnalyticsAPI --> AnalyticsTable
  FileAPI --> FilesTable
```

## Explanation
- **Users**: Four roles (Student, HR, Admin, Finance) each have their own dashboard and features.
- **Flutter App**: Each screen corresponds to a major feature/module.
- **API**: Go REST API exposes endpoints for all resources, with role-based access control.
- **Database**: Each API endpoint maps to one or more tables in a relational database.

This diagram serves as a blueprint for backend integration and future expansion. 

## Detailed Flow & Sequence Diagram

```mermaid
sequenceDiagram
  autonumber
  participant Student
  participant HR
  participant Admin
  participant Finance
  participant FlutterApp as Flutter App
  participant API as Go REST API
  participant DB as Database

  Student->>FlutterApp: Open app, select role (Student)
  FlutterApp->>API: POST /api/login
  API->>DB: users (verify credentials)
  API-->>FlutterApp: JWT token
  FlutterApp->>API: GET /api/courses
  API->>DB: courses (fetch list)
  API-->>FlutterApp: courses JSON
  FlutterApp->>API: GET /api/jobs
  API->>DB: jobs (fetch list)
  API-->>FlutterApp: jobs JSON
  FlutterApp->>API: GET /api/queries
  API->>DB: queries (fetch for student)
  API-->>FlutterApp: queries JSON
  FlutterApp->>API: POST /api/queries (new query)
  API->>DB: queries (insert)
  API-->>FlutterApp: query created
  FlutterApp->>API: POST /api/applications (apply for job)
  API->>DB: applications (insert)
  API-->>FlutterApp: application status

  HR->>FlutterApp: Open app, select role (HR)
  FlutterApp->>API: POST /api/login
  API->>DB: users (verify credentials)
  API-->>FlutterApp: JWT token
  FlutterApp->>API: GET /api/applications
  API->>DB: applications (fetch all)
  API-->>FlutterApp: applications JSON
  FlutterApp->>API: GET /api/queries
  API->>DB: queries (fetch all)
  API-->>FlutterApp: queries JSON
  FlutterApp->>API: POST /api/queries/{id}/responses
  API->>DB: queries (update responses)
  API-->>FlutterApp: response added

  Admin->>FlutterApp: Open app, select role (Admin)
  FlutterApp->>API: POST /api/login
  API->>DB: users (verify credentials)
  API-->>FlutterApp: JWT token
  FlutterApp->>API: GET /api/users
  API->>DB: users (fetch all)
  API-->>FlutterApp: users JSON
  FlutterApp->>API: GET /api/courses
  API->>DB: courses (fetch all)
  API-->>FlutterApp: courses JSON
  FlutterApp->>API: GET /api/audit
  API->>DB: analytics (fetch logs)
  API-->>FlutterApp: audit logs

  Finance->>FlutterApp: Open app, select role (Finance)
  FlutterApp->>API: POST /api/login
  API->>DB: users (verify credentials)
  API-->>FlutterApp: JWT token
  FlutterApp->>API: GET /api/payments
  API->>DB: applications (fetch payments)
  API-->>FlutterApp: payments JSON
  FlutterApp->>API: GET /api/reports
  API->>DB: analytics (fetch reports)
  API-->>FlutterApp: reports JSON
```

## Database ER Diagram

```mermaid
erDiagram
  USERS ||--o{ APPLICATIONS : applies
  USERS ||--o{ QUERIES : submits
  USERS ||--o{ FILES : uploads
  USERS ||--o{ COURSES : enrolls
  COURSES ||--o{ APPLICATIONS : for
  COURSES ||--o{ QUERIES : about
  JOBS ||--o{ APPLICATIONS : for
  APPLICATIONS }o--|| JOBS : relates
  APPLICATIONS }o--|| COURSES : relates
  QUERIES ||--o{ QUERY_RESPONSES : has
  FILES ||--|| USERS : owned_by
  ANALYTICS ||--o{ USERS : tracks

  USERS {
    string id PK
    string name
    string email
    string role
    string password_hash
  }
  COURSES {
    string id PK
    string title
    string description
    string instructor
    string domain
  }
  JOBS {
    string id PK
    string title
    string company
    string salary
    string location
  }
  APPLICATIONS {
    string id PK
    string user_id FK
    string job_id FK
    string course_id FK
    string status
    string resume_file_id FK
  }
  QUERIES {
    string id PK
    string user_id FK
    string category
    string status
    string priority
    string question
  }
  QUERY_RESPONSES {
    string id PK
    string query_id FK
    string by_user_id FK
    string message
    string time
  }
  FILES {
    string id PK
    string user_id FK
    string path
    string type
  }
  ANALYTICS {
    string id PK
    string type
    string value
    string timestamp
  }
```

---

This expanded documentation provides a clear, detailed flow and database structure for backend/API implementation and future scaling. 