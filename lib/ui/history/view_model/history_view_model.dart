import 'package:flutter/foundation.dart';
import '../../../domain/models/workout_session.dart';

class HistoryViewModel extends ChangeNotifier {
  final int totalSessions = 18;
  final int targetSessions = 22;
  final int consistencyPercent = 82;

  final DateTime currentMonth = DateTime(2023, 10);

  final Set<int> attendedDays = {
    3, 4, 5, 6, 9, 10, 11, 12, 13, 16,
  };

  final List<WorkoutSession> recentActivity = [
    WorkoutSession(
      id: '1',
      name: 'Upper Body Power',
      dateTime: DateTime(2023, 10, 13, 10, 15),
      durationMinutes: 62,
      calories: 480,
      category: 'strength',
    ),
    WorkoutSession(
      id: '2',
      name: 'High Intensity Cardio',
      dateTime: DateTime(2023, 10, 12, 18, 30),
      durationMinutes: 35,
      calories: 320,
      category: 'cardio',
    ),
    WorkoutSession(
      id: '3',
      name: 'Active Recovery Yoga',
      dateTime: DateTime(2023, 10, 10, 8, 0),
      durationMinutes: 45,
      calories: 160,
      category: 'recovery',
    ),
    WorkoutSession(
      id: '4',
      name: 'Leg Day: Hypertrophy',
      dateTime: DateTime(2023, 10, 9, 7, 15),
      durationMinutes: 78,
      calories: 540,
      category: 'strength',
    ),
  ];
}
