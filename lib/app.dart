import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'routing/router.dart';
import 'ui/core/themes/app_theme.dart';
import 'ui/core/view_model/theme_notifier.dart';
import 'ui/auth/view_model/login_view_model.dart';
import 'ui/dashboard/view_model/dashboard_view_model.dart';
import 'ui/workout_tracker/view_model/workout_tracker_view_model.dart';
import 'ui/history/view_model/history_view_model.dart';
import 'ui/profile/view_model/profile_view_model.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => DashboardViewModel()),
        ChangeNotifierProvider(create: (_) => WorkoutTrackerViewModel()),
        ChangeNotifierProvider(create: (_) => HistoryViewModel()),
        ChangeNotifierProvider(create: (_) => ProfileViewModel()),
      ],
      child: Consumer<ThemeNotifier>(
        builder: (_, themeNotifier, __) => MaterialApp(
          title: 'EnerGym',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: themeNotifier.mode,
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: AppRouter.login,
        ),
      ),
    );
  }
}
