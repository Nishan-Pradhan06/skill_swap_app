# SkillSwap - Skill Sharing Platform

A comprehensive platform designed to facilitate skill sharing between mentors and learners. This project consists of a Flutter mobile application and a Django-based backend server.

## 🛠 Technology Stack

### Frontend (Mobile App)
- **Framework**: [Flutter](https://flutter.dev/) `3.38.5`
- **Language**: [Dart](https://dart.dev/) `3.10.4`
- **Architecture**: Feature-first Architecture
- **State Management**: [Flutter Bloc](https://pub.dev/packages/flutter_bloc) & Cubit
- **Dependency Injection**: [GetIt](https://pub.dev/packages/get_it)
- **Navigation**: [GoRouter](https://pub.dev/packages/go_router)
- **API Communication**: [Dio](https://pub.dev/packages/dio)
- **Local Storage**: [Shared Preferences](https://pub.dev/packages/shared_preferences) & [Flutter Secure Storage](https://pub.dev/packages/flutter_secure_storage)
- **Real-time Notifications**: [Firebase Cloud Messaging (FCM)](https://firebase.google.com/docs/cloud-messaging)
- **Payment Gateway**: [Khalti](https://khalti.com/)

### Backend (Server)
- **Framework**: [Django](https://www.djangoproject.com/) `5.2.11`
- **Language**: [Python](https://www.python.org/) `3.13` (based on environment)
- **API Framework**: [Django REST Framework (DRF)](https://www.django-rest-framework.org/)
- **Database**: [MySQL](https://www.mysql.com/)
- **ORM**: Django Native ORM
- **Admin Interface**: [Django Jazzmin](https://github.com/farridav/django-jazzmin) `3.0.2`
- **Push Notifications Server**: Firebase Admin SDK

## 📁 Project Structure

### Flutter (Frontend)
```text
skill_swap/
├── lib/
│   ├── core/           # Shared utilities, widgets, and theme
│   └── features/        # Feature-based modules (auth, profile, skill_swap, etc.)
│       └── [feature]/
│           ├── pages/
│           ├── widgets/
│           ├── blocs/
│           ├── cubits/
│           ├── repositories/
│           └── models/
└── assets/             # Images, SVGs, Lottie animations, and fonts
```

### Django (Backend)
```text
backend/
└── skillswap/
    ├── myapp/          # Main application logic (models, views, serializers)
    ├── skillswap/      # Project configuration (settings, urls)
    └── manage.py       # Django management script
```

## 🚀 Key Features
- **Mentor/Learner Roles**: Dynamic role switching within the app.
- **Skill Posting**: Mentors can post skills they offer with availability slots.
- **Booking System**: Learners can book sessions using a points-based system.
- **Points System**: Integrated points management with rewards for logins and completed sessions.
- **Khalti Integration**: Secure point purchasing via Khalti.
- **Push Notifications**: Real-time alerts for booking requests, status updates, and rewards.
- **Profile Management**: Detailed profiles with certifications, work experience, and portfolios.
