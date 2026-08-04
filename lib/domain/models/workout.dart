import 'exercise.dart';

class Workout {
  final String id;
  final String name;
  final DateTime date;
  final List<Exercise> exercises;
  final String? notes;

  const Workout({
    required this.id,
    required this.name,
    required this.date,
    required this.exercises,
    this.notes,
  });

  Workout copyWith({
    String? id,
    String? name,
    DateTime? date,
    List<Exercise>? exercises,
    String? notes,
  }) {
    return Workout(
      id: id ?? this.id,
      name: name ?? this.name,
      date: date ?? this.date,
      exercises: exercises ?? this.exercises,
      notes: notes ?? this.notes,
    );
  }

  int get totalSets => exercises.fold(0, (sum, e) => sum + e.sets);
}
