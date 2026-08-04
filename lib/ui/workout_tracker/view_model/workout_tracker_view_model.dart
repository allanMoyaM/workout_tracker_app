import 'dart:async';
import 'package:flutter/foundation.dart';

class UpcomingExercise {
  final int number;
  final String name;
  UpcomingExercise({required this.number, required this.name});
}

class WorkoutTrackerViewModel extends ChangeNotifier {
  String currentExercise = 'SENTADILLA SMITH';
  int currentSet = 3;
  int totalSets = 4;
  int targetReps = 12;
  double targetWeightKg = 80;

  double weightKg = 82.5;
  int reps = 10;

  int restSeconds = 105; // 01:45
  bool isResting = false;
  Timer? _timer;

  double velocity = 0.85;

  final List<UpcomingExercise> upcoming = [
    UpcomingExercise(number: 2, name: 'Leg Extension'),
    UpcomingExercise(number: 3, name: 'Smith Deadlift'),
    UpcomingExercise(number: 4, name: 'Smith Bench Press'),
  ];

  String get restFormatted {
    final m = restSeconds ~/ 60;
    final s = restSeconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  void incrementWeight() {
    weightKg += 2.5;
    notifyListeners();
  }

  void decrementWeight() {
    if (weightKg > 0) weightKg -= 2.5;
    notifyListeners();
  }

  void incrementReps() {
    reps++;
    notifyListeners();
  }

  void decrementReps() {
    if (reps > 0) reps--;
    notifyListeners();
  }

  void completeSet() {
    if (currentSet < totalSets) {
      currentSet++;
      _startRest();
    }
    notifyListeners();
  }

  void _startRest() {
    isResting = true;
    restSeconds = 105;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (restSeconds > 0) {
        restSeconds--;
        notifyListeners();
      } else {
        isResting = false;
        _timer?.cancel();
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
