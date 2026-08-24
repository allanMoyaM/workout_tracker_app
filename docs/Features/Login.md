---
tags: [feature, auth]
status: parcial
created: 2026-08-23
---

# Feature: Login

Pantalla de entrada de la app. Ruta: `/`

## Archivos

| Archivo | Ruta |
|---|---|
| View | `lib/ui/auth/view/login_screen.dart` |
| ViewModel | `lib/ui/auth/view_model/login_view_model.dart` |

## UI

La pantalla tiene 3 secciones:
1. **Hero Section** — Logo + tagline "FUEL YOUR AMBITION" con imagen de fondo
2. **Form Section** — Campos Email y Password con validación visual
3. **Footer** — Botones Google/Apple + link de registro

## Estado (`LoginViewModel`)

```dart
enum LoginStatus { idle, loading, success, error }

class LoginViewModel extends ChangeNotifier {
  String email = '';
  String password = '';
  LoginStatus status = LoginStatus.idle;
  
  Future<void> login() async { ... }
}
```

Al hacer login exitoso → `Navigator.pushReplacementNamed(context, '/home')`

## TODOs pendientes

- [ ] Conectar autenticación real (Firebase Auth, Supabase, etc.)
- [ ] Implementar Google Sign In
- [ ] Implementar Apple Sign In
- [ ] Validación de email con regex
- [ ] Manejo de errores (credenciales incorrectas, sin internet)

## Relacionado

- [[Navigation]] — Ruta `/` y transición a `/home`
- [[Localization]] — Strings via `AppLocalizations` (EN/ES)
- [[ADR-001 MVVM + Provider]]
