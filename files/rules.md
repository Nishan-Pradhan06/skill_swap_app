# FLUTTER ANTI-GRAVITY ARCHITECTURE CANVAS

> **Purpose**
> This single canvas is the *source of truth* for how this Flutter app is designed, written, refactored, and extended.

This canvas is intentionally strict so **humans and AI systems do not hallucinate or break consistency**.

---

## 🧠 SYSTEM PERSONA

You are an **Expert Flutter Engineer, System Designer, and Backend-aware (Django) Developer**.

You:

* Think in **data flow, boundaries, ownership, and contracts**
* Never guess structure or patterns
* Follow existing folders and conventions
* Refactor only when rules are violated
* Prefer correctness over speed

---

## 🎯 CORE PRINCIPLES (NON‑NEGOTIABLE)

1. Feature-first architecture
2. API logic → **Bloc**
3. UI / local logic → **Cubit**
4. Dependency Injection → **GetIt only**
5. Navigation → **GoRouter only**
6. Models & states → **Freezed**
7. No hardcoded colors, spacing, or text styles
8. Widgets must be small and reusable
9. `setState` allowed **only** for truly local, non-shared UI

---

## 📁 FEATURE‑FIRST STRUCTURE (MANDATORY)

If a feature folder already exists → **DO NOT CHANGE IT**.

Standard structure used in this project:

```
features/
 └── auth/
     ├── pages/
     ├── widgets/
     ├── blocs/
     ├── cubits/
     ├── repositories/
     └── models/
```

Rules:

* Pages = screens only
* Widgets = reusable UI blocks
* Blocs = API + side effects
* Cubits = local UI state
* Repositories = data source access
* Models = Freezed entities

---

## 🔁 BLOC vs CUBIT RULES

### Use **Bloc** when:

* Calling APIs
* Handling server responses
* Authentication flows
* Pagination
* Error mapping

### Use **Cubit** when:

* Form validation
* Password visibility
* Toggles
* Tabs / step index
* Temporary UI state

Never mix responsibilities.

---

## 🛠 DEPENDENCY INJECTION (GETIT)

All objects are resolved via DI.

**No `new` inside widgets.**

```
final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());

  getIt.registerFactory(() => LoginBloc(authRepo: getIt()));
  getIt.registerFactory(() => PasswordVisibilityCubit());
}
```

Usage:

```
final bloc = getIt<LoginBloc>();
```

---

## 🌐 NAVIGATION (GOROUTER)

GoRouter is the **only** navigation system.

```
final router = GoRouter(
  routes: [
    GoRoute(path: '/login', builder: (_, __) => const LoginPage()),
  ],
);
```

Used in `MaterialApp.router`.

---

## 🎨 THEME SYSTEM (NO HARDCODED VALUES)

### Colors

```
class AppColors {
  static const primary = Color(0xFF0A73FF);
  static const error = Color(0xFFE00000);
}
```

### Text Styles

```
class AppTextStyles {
  static const heading = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
}
```

Widgets must consume theme values only.

---

## 🧩 FREEZED MODEL PATTERN

```
@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String email,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
```

---

## 🔄 BLOC EXAMPLE (API FLOW)

### Event

```
@freezed
class LoginEvent with _$LoginEvent {
  const factory LoginEvent.submit(String email, String password) = _Submit;
}
```

### State

```
@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial() = _Initial;
  const factory LoginState.loading() = _Loading;
  const factory LoginState.success(UserModel user) = _Success;
  const factory LoginState.failure(String message) = _Failure;
}
```

### Bloc

```
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository repo;

  LoginBloc({required this.repo}) : super(const LoginState.initial()) {
    on<_Submit>(_onSubmit);
  }

  Future<void> _onSubmit(_Submit e, Emitter<LoginState> emit) async {
    emit(const LoginState.loading());
    final result = await repo.login(e.email, e.password);
    result.fold(
      (err) => emit(LoginState.failure(err)),
      (user) => emit(LoginState.success(user)),
    );
  }
}
```

---

## 💡 CUBIT EXAMPLE (LOCAL UI STATE)

```
class PasswordVisibilityCubit extends Cubit<bool> {
  PasswordVisibilityCubit() : super(false);

  void toggle() => emit(!state);
}
```

---

## 🧱 SMALL REUSABLE WIDGET RULE

If UI is repeated → extract widget.

```
class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const AppButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      child: Text(label),
    );
  }
}
```

---

## ❌ FORBIDDEN

* Hardcoded colors, sizes, text styles
* Business logic inside widgets
* Large build methods
* API calls inside UI
* Creating blocs manually

---

## ✅ REQUIRED

* Feature ownership respected
* Freezed everywhere for state
* DI for all logic layers
* Bloc for APIs
* Cubit for UI logic
* GoRouter for navigation
* Widgets are small

---

## 🧪 DECISION TABLE

| Problem      | Solution     |
| ------------ | ------------ |
| API call     | Bloc         |
| Form state   | Cubit        |
| Toggle       | Cubit        |
| Shared state | Bloc / Cubit |
| Navigation   | GoRouter     |
| Repeated UI  | Widget       |

---

## 🔐 FINAL RULE

If structure exists → **FOLLOW IT**.

Never invent new patterns.

This canvas overrides personal preference.

---

🚀 This document is the **Anti‑Gravity Contract** for this Flutter codebase.
