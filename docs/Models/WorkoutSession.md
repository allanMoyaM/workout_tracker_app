---
tags: [model, domain]
created: 2026-08-23
---

# Modelo: WorkoutSession

Registro de una sesión de entrenamiento completada. Se usa en [[History]] para mostrar actividad reciente y asistencia.

**Ruta:** `lib/domain/models/workout_session.dart`

## Campos

| Campo | Tipo | Descripción |
|---|---|---|
| `id` | `String` | UUID único |
| `name` | `String` | Nombre de la sesión (ej. "Push Day A") |
| `dateTime` | `DateTime` | Fecha y hora de inicio |
| `durationMinutes` | `int` | Duración en minutos |
| `calories` | `int` | Calorías quemadas |
| `category` | `String` | `strength` / `cardio` / `recovery` |

## Uso en History

```dart
// HistoryViewModel
List<WorkoutSession> recentActivity = [
  WorkoutSession(name: 'Push Day A', category: 'strength', durationMinutes: 62, ...),
  WorkoutSession(name: 'Morning Run', category: 'cardio', durationMinutes: 38, ...),
  WorkoutSession(name: 'Yoga Flow', category: 'recovery', durationMinutes: 45, ...),
];
```

## Pendiente

Actualmente hardcodeada en el ViewModel. Ver [[Data Flow]] y [[TODOs]] para la migración a persistencia real.

## Relacionado

- [[History]] — Feature que muestra WorkoutSessions
- [[Dashboard]] — Usa sessions para calcular streak y asistencia (pendiente)
- [[Workout]] — La sesión es la ejecución de un Workout
