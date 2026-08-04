class UserProfile {
  final String name;
  final String title;
  final String badge;
  final int level;
  final double weightKg;
  final double heightCm;
  final double bodyFatPercent;
  final double targetWeightKg;
  final int weeklySessionTarget;
  final int weeklySessionsDone;

  const UserProfile({
    required this.name,
    required this.title,
    required this.badge,
    required this.level,
    required this.weightKg,
    required this.heightCm,
    required this.bodyFatPercent,
    required this.targetWeightKg,
    required this.weeklySessionTarget,
    required this.weeklySessionsDone,
  });

  double get weightGoalProgress =>
      (weightKg - targetWeightKg).abs() / weightKg;

  double get weeklySessionProgress =>
      weeklySessionsDone / weeklySessionTarget;
}
