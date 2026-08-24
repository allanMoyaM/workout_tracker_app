---
tags: [model, domain]
created: 2026-08-23
---

# Modelo: Workout

Entidad principal del dominio. Representa una rutina de entrenamiento con sus ejercicios.

**Ruta:** `lib/domain/models/workout.dart`

## Campos

| Campo | Tipo | Descripción |
|---|---|---|
| `id` | `String` | UUID único |
| `name` | `String` | Nombre de la rutina (ej. "Push Day A") |
| `date` | `DateTime` | Fecha programada |
| `exercises` | `List<Exercise>` | Lista de ejercicios |
| `notes` | `String?` | Notas opcionales |

## Computed properties

```dart
int get totalSets => exercises.fold(0, (sum, e) => sum + e.sets);
```

## Inmutabilidad

```dart
Workout copyWith({
  String? id,
  String? name,
  DateTime? date,
  List<Exercise>? exercises,
  String? notes,
})
```

## Relacionado

- [[Exercise]] — Entidad hija dentro de Workout
- [[WorkoutSession]] — Registro de una ejecución de este Workout
- [[Data Flow]] — `WorkoutRepository` gestiona la lista de Workouts
