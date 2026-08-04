import 'package:flutter/foundation.dart';
import '../../../domain/models/workout.dart';
import '../../../data/repositories/workout_repository.dart';

class HomeViewModel extends ChangeNotifier {
  final WorkoutRepository _repository;

  HomeViewModel(this._repository);

  List<Workout> _workouts = [];
  bool _isLoading = false;
  String? _error;

  List<Workout> get workouts => _workouts;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadWorkouts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _workouts = await _repository.getAll();
    } catch (e) {
      _error = 'Error cargando entrenamientos';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteWorkout(String id) async {
    await _repository.delete(id);
    await loadWorkouts();
  }
}
