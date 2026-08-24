---
tags: [development, todos]
created: 2026-08-23
---

# TODOs en el Código

Pendientes encontrados directamente en comentarios del código fuente.

## `data/services/local_storage_service.dart`

```dart
// Stub en memoria — aquí irá SQLite/Hive más adelante
```

→ Ver [[Data Flow]] y [[Roadmap]]

## `ui/auth/view_model/login_view_model.dart`

```dart
// TODO: Connect real authentication service
// TODO: Google Sign In
// TODO: Apple Sign In
```

→ Ver [[Login]] y [[Roadmap]]

## `ui/dashboard/view_model/dashboard_view_model.dart`

Datos hardcodeados sin TODO explícito, pero derivados de datos reales eventualmente:
- `streakDays` → calcular desde `WorkoutSession`
- `attendanceCount` → contar sesiones del mes
- `nextSession` → plan del usuario

→ Ver [[Dashboard]]

## `ui/workout_tracker/view_model/workout_tracker_view_model.dart`

- Rest timer es un valor estático, no una cuenta regresiva real
- `velocity` es hardcodeado

→ Ver [[Workout Tracker]]

## `ui/history/view_model/history_view_model.dart`

- `recentActivity` es una lista hardcodeada
- `attendedDays` es un Set fijo, no calculado

→ Ver [[History]]

## `ui/profile/view_model/profile_view_model.dart`

- `UserProfile` es un objeto hardcodeado en el constructor

→ Ver [[Profile]] y [[UserProfile]]

## Relacionado

- [[Roadmap]] — Visión de largo plazo
- [[Data Flow]] — Arquitectura de datos a resolver
