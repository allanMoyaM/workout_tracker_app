---
tags: [feature, workout-tracker]
status: demo
created: 2026-08-23
---

# Feature: Workout Tracker

Pantalla de seguimiento de sesión activa (tab 1). El usuario registra sets, reps y peso en tiempo real.

## Archivos

| Archivo | Ruta |
|---|---|
| View | `lib/ui/workout_tracker/view/workout_tracker_screen.dart` |
| ViewModel | `lib/ui/workout_tracker/view_model/workout_tracker_view_model.dart` |

## UI

| Sección | Descripción |
|---|---|
| Ejercicio actual | Nombre del ejercicio en curso |
| Rest Timer | Tiempo de descanso en segundos (cuenta regresiva) |
| Velocity | Velocidad en m/s |
| Series card | Set actual / total sets + target (reps @ kg) |
| Weight counter | Spinner +/- para peso en KG |
| Reps counter | Spinner +/- para repeticiones |
| Complete Set button | Marca el set como completado |
| Upcoming exercises | Lista de ejercicios restantes |

## Estado (`WorkoutTrackerViewModel`)

```dart
String currentExercise;     // "Bench Press"
int currentSet;             // 2
int totalSets;              // 4
int targetReps;             // 8
double targetWeightKg;      // 80.0
double weightKg;            // 80.0
int reps;                   // 8
double velocity;            // 0.72
int restSeconds;            // 45
List<UpcomingExercise> upcoming;
```

Acciones: `incrementWeight()`, `decrementWeight()`, `incrementReps()`, `decrementReps()`, `completeSet()`

## TODOs pendientes

- [ ] Rest timer real con `Timer.periodic`
- [ ] Guardar set completado en `WorkoutSession`
- [ ] Navegar al siguiente ejercicio automáticamente
- [ ] Finalizar sesión y persistir en `LocalStorageService`
- [ ] Velocity real (conexión con sensor o cálculo manual)

## Relacionado

- [[Exercise]] — Entidad de ejercicio
- [[WorkoutSession]] — Donde se guardan los sets completados
- [[Data Flow]] — Persistencia pendiente
