import 'package:flutter/foundation.dart';
import '../../../domain/models/workout.dart';
import '../../../domain/models/exercise.dart';
import '../../../data/repositories/workout_repository.dart';

class WorkoutViewModel extends ChangeNotifier {
  final WorkoutRepository _repository;

  WorkoutViewModel(this._repository);

  Workout? _workout;
  bool _isLoading = false;
  bool _isSaved = false;

  Workout? get workout => _workout;
  bool get isLoading => _isLoading;
  bool get isSaved => _isSaved;

  void initNew(String name) {
    _workout = Workout(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      date: DateTime.now(),
      exercises: [],
    );
    _isSaved = false;
    notifyListeners();
  }

  Future<void> load(String id) async {
    _isLoading = true;
    notifyListeners();
    _workout = await _repository.getById(id);
    _isLoading = false;
    notifyListeners();
  }

  void addExercise(Exercise exercise) {
    if (_workout == null) return;
    _workout = _workout!.copyWith(
      exercises: [..._workout!.exercises, exercise],
    );
    _isSaved = false;
    notifyListeners();
  }

  void removeExercise(String exerciseId) {
    if (_workout == null) return;
    _workout = _workout!.copyWith(
      exercises: _workout!.exercises.where((e) => e.id != exerciseId).toList(),
    );
    _isSaved = false;
    notifyListeners();
  }

  Future<void> save() async {
    if (_workout == null) return;
    _isLoading = true;
    notifyListeners();
    await _repository.save(_workout!);
    _isSaved = true;
    _isLoading = false;
    notifyListeners();
  }
}
