import '../../domain/models/workout.dart';
import '../../domain/models/exercise.dart';

// Stub en memoria — aquí irá SQLite/Hive más adelante
class LocalStorageService {
  final List<Workout> _workouts = [];

  Future<List<Workout>> getWorkouts() async => List.unmodifiable(_workouts);

  Future<Workout?> getWorkoutById(String id) async {
    try {
      return _workouts.firstWhere((w) => w.id == id);
    } catch (_) {
      return null;
    }
  }

  Future<void> saveWorkout(Workout workout) async {
    final index = _workouts.indexWhere((w) => w.id == workout.id);
    if (index >= 0) {
      _workouts[index] = workout;
    } else {
      _workouts.add(workout);
    }
  }

  Future<void> deleteWorkout(String id) async {
    _workouts.removeWhere((w) => w.id == id);
  }

  Future<List<Exercise>> getExercises() async {
    return _workouts.expand((w) => w.exercises).toList();
  }
}
