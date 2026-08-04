import 'package:flutter/foundation.dart';

class DashboardViewModel extends ChangeNotifier {
  final int streakDays = 5;
  final String lastWorkoutName = 'EMPUJE (PECHO/TRÍCEPS)';
  final String lastWorkoutDetail = 'Ayer • 65 min • 420 kcal';
  final String nextSessionName = 'TRACCIÓN (ESPALDA)';
  final String nextSessionDetail = 'Hoy • Programado 18:00';
  final int monthlyGoalPercent = 86;

  // Days with attendance this month (1-indexed)
  final Set<int> attendedDays = {1, 2, 3, 4, 5, 8, 10, 12, 15};
}
