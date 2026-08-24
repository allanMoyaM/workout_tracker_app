---
tags: [model, domain]
created: 2026-08-23
---

# Modelo: Exercise

Entidad de dominio que representa un ejercicio dentro de una rutina.

**Ruta:** `lib/domain/models/exercise.dart`

## Campos

| Campo | Tipo | Descripción |
|---|---|---|
| `id` | `String` | UUID único |
| `name` | `String` | Nombre del ejercicio (ej. "Bench Press") |
| `muscleGroup` | `String` | Grupo muscular (ej. "Chest", "Back") |
| `sets` | `int` | Número de series |
| `reps` | `int` | Repeticiones por serie |
| `weightKg` | `double` | Peso en kilogramos |

## Inmutabilidad

```dart
Exercise copyWith({
  String? id,
  String? name,
  String? muscleGroup,
  int? sets,
  int? reps,
  double? weightKg,
})
```

## Relacionado

- [[Workout]] — Un Workout contiene una lista de Exercises
- [[Workout Tracker]] — Feature que consume Exercise en tiempo real
