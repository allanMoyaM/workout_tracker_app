---
tags: [architecture, data, repository]
created: 2026-08-23
---

# Flujo de Datos

Cómo viaja la información desde el almacenamiento hasta la pantalla.

## Flujo completo

```
LocalStorageService
      ↓  (CRUD en memoria / futuro: SQLite)
WorkoutRepository
      ↓  (abstracción de acceso a datos)
HomeViewModel / WorkoutViewModel
      ↓  (ChangeNotifier, notifyListeners)
HomeScreen / WorkoutScreen
      ↓  (context.watch → rebuild)
UI
```

## Implementación actual

`LocalStorageService` es un **stub en memoria** — los datos se pierden al reiniciar la app. Es el punto de sustitución para SQLite o Hive en el futuro.

```dart
// data/services/local_storage_service.dart
class LocalStorageService {
  final List<Workout> _workouts = [..._seed]; // Datos hardcodeados de ejemplo
  
  List<Workout> getWorkouts() => List.unmodifiable(_workouts);
  void saveWorkout(Workout w) { ... }
  void deleteWorkout(String id) { ... }
}
```

`WorkoutRepository` envuelve el servicio y expone una interfaz limpia:

```dart
// data/repositories/workout_repository.dart
class WorkoutRepository {
  final LocalStorageService _service;
  
  List<Workout> getAll() => _service.getWorkouts();
  void save(Workout w) => _service.saveWorkout(w);
  void delete(String id) => _service.deleteWorkout(id);
}
```

## ViewModels con datos demo

Varios ViewModels tienen datos **hardcodeados directamente** (sin repositorio) porque representan features aún no conectadas a persistencia:

| ViewModel | Datos |
|---|---|
| `DashboardViewModel` | Streak, asistencia, goals — hardcodeados |
| `HistoryViewModel` | Sesiones recientes — hardcodeadas |
| `ProfileViewModel` | UserProfile — hardcodeado |
| `WorkoutTrackerViewModel` | Ejercicio actual, sets — hardcodeados |
| `HomeViewModel` | Rutinas — usa `WorkoutRepository` ✓ |
| `WorkoutViewModel` | Rutina editada — usa `WorkoutRepository` ✓ |

## Próximos pasos

Ver [[Roadmap]] para el plan de migración a persistencia real.

## Relacionado

- [[ADR-002 Repository Pattern]] — Decisión de usar repositorios
- [[Workout]] — Modelo principal del flujo
- [[Exercise]] — Entidad dentro de Workout
