import '../../domain/models/workout.dart';
import '../services/local_storage_service.dart';

class WorkoutRepository {
  final LocalStorageService _storage;

  WorkoutRepository(this._storage);

  Future<List<Workout>> getAll() => _storage.getWorkouts();

  Future<Workout?> getById(String id) => _storage.getWorkoutById(id);

  Future<void> save(Workout workout) => _storage.saveWorkout(workout);

  Future<void> delete(String id) => _storage.deleteWorkout(id);
}
