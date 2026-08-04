class WorkoutSession {
  final String id;
  final String name;
  final DateTime dateTime;
  final int durationMinutes;
  final int calories;
  final String category; // strength, cardio, recovery

  const WorkoutSession({
    required this.id,
    required this.name,
    required this.dateTime,
    required this.durationMinutes,
    required this.calories,
    required this.category,
  });
}
