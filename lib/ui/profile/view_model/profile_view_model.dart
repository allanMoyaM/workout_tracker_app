import 'package:flutter/foundation.dart';
import '../../../domain/models/user_profile.dart';

class ProfileViewModel extends ChangeNotifier {
  bool notificationsEnabled = true;

  final UserProfile profile = const UserProfile(
    name: 'ALLAN MOYA',
    title: 'ELITE PERFORMANCE TRACK',
    badge: 'PRO',
    level: 42,
    weightKg: 85,
    heightCm: 183,
    bodyFatPercent: 12.4,
    targetWeightKg: 82,
    weeklySessionTarget: 5,
    weeklySessionsDone: 4,
  );

  // Weekly activity bars (0.0 - 1.0) Mon-Sat
  final List<double> weeklyActivity = [0.6, 0.85, 0.4, 0.9, 0.7, 0.5];
  final List<String> weekDays = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'];

  void toggleNotifications() {
    notificationsEnabled = !notificationsEnabled;
    notifyListeners();
  }
}
