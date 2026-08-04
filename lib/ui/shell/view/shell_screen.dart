import 'package:flutter/material.dart';
import '../../core/themes/app_color_scheme.dart';
import '../../core/widgets/energym_bottom_nav.dart';
import '../../dashboard/view/dashboard_screen.dart';
import '../../workout_tracker/view/workout_tracker_screen.dart';
import '../../history/view/history_screen.dart';
import '../../profile/view/profile_screen.dart';

class ShellScreen extends StatefulWidget {
  const ShellScreen({super.key});

  @override
  State<ShellScreen> createState() => _ShellScreenState();
}

class _ShellScreenState extends State<ShellScreen> {
  int _currentIndex = 0;

  static const _pages = [
    DashboardScreen(),
    WorkoutTrackerScreen(),
    HistoryScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorScheme.of(context).background,
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: EnerGymBottomNav(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
      ),
    );
  }
}
