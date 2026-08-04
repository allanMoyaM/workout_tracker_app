import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/dashboard_view_model.dart';
import '../../core/themes/app_colors.dart';
import '../../core/themes/app_color_scheme.dart';
import '../../core/widgets/energym_app_bar.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<DashboardViewModel>();
    final colors = AppColorScheme.of(context);
    return Scaffold(
      backgroundColor: colors.background,
      appBar: const EnerGymAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('¿Listo para superar tus límites hoy?',
                style: TextStyle(color: colors.textSecondary, fontSize: 13)),
            const SizedBox(height: 16),
            _StreakCard(streakDays: vm.streakDays),
            const SizedBox(height: 12),
            _InfoCard(
              label: 'ÚLTIMO ENTRENO',
              trailing: Icon(Icons.history, color: colors.textSecondary, size: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(vm.lastWorkoutName,
                      style: TextStyle(color: colors.textPrimary, fontSize: 16, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  Text(vm.lastWorkoutDetail,
                      style: TextStyle(color: colors.textSecondary, fontSize: 12)),
                ],
              ),
            ),
            const SizedBox(height: 12),
            _InfoCard(
              label: 'PRÓXIMA SESIÓN',
              trailing: Icon(Icons.calendar_today_outlined, color: colors.textSecondary, size: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(vm.nextSessionName,
                      style: TextStyle(color: colors.textPrimary, fontSize: 16, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  Text(vm.nextSessionDetail,
                      style: TextStyle(color: colors.textSecondary, fontSize: 12)),
                ],
              ),
            ),
            const SizedBox(height: 12),
            _AttendanceCard(attendedDays: vm.attendedDays),
            const SizedBox(height: 12),
            _GoalCard(percent: vm.monthlyGoalPercent),
            const SizedBox(height: 12),
            _CommunityCard(),
          ],
        ),
      ),
    );
  }
}

class _StreakCard extends StatelessWidget {
  final int streakDays;
  const _StreakCard({required this.streakDays});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.accentBlue.withOpacity(0.35), AppColors.accentBlue.withOpacity(0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.accent.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('RACHA DE ENTRENAMIENTO',
              style: TextStyle(color: AppColors.accent, fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: 1.5)),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('$streakDays',
                  style: TextStyle(
                      color: AppColorScheme.of(context).textPrimary,
                      fontSize: 56, fontWeight: FontWeight.w900, height: 1)),
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text('DÍAS',
                    style: TextStyle(color: AppColorScheme.of(context).textSecondary,
                        fontSize: 18, fontWeight: FontWeight.w700)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(color: AppColors.accent, borderRadius: BorderRadius.circular(10)),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.play_arrow_rounded, color: Colors.black, size: 20),
                  SizedBox(width: 8),
                  Text('INICIAR ENTRENAMIENTO',
                      style: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.w800, letterSpacing: 1)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String label;
  final Widget child;
  final Widget? trailing;
  const _InfoCard({required this.label, required this.child, this.trailing});

  @override
  Widget build(BuildContext context) {
    final colors = AppColorScheme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.inputBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label,
                  style: TextStyle(color: colors.textSecondary, fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: 1.5)),
              if (trailing != null) trailing!,
            ],
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

class _AttendanceCard extends StatelessWidget {
  final Set<int> attendedDays;
  const _AttendanceCard({required this.attendedDays});

  @override
  Widget build(BuildContext context) {
    final colors = AppColorScheme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.inputBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('ASISTENCIA',
                  style: TextStyle(color: colors.textSecondary, fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: 1.5)),
              const Text('Mayo 2024', style: TextStyle(color: AppColors.accent, fontSize: 11, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ['L', 'M', 'M', 'J', 'V', 'S', 'D']
                .map((d) => Text(d, style: TextStyle(color: colors.textSecondary, fontSize: 11, fontWeight: FontWeight.w600)))
                .toList(),
          ),
          const SizedBox(height: 8),
          _buildCalendarWeek(context, [null, null, null, null, null, null, null]),
          _buildCalendarWeek(context, [null, null, null, null, null, 1, 2]),
          _buildCalendarWeek(context, [3, 4, 5, 6, 7, 8, 9], highlightStart: 1, highlightEnd: 5),
          _buildCalendarWeek(context, [10, 11, 12, 13, 14, 15, 16]),
          _buildCalendarWeek(context, [17, 18, 19, 20, 21, 22, 23]),
          _buildCalendarWeek(context, [24, 25, 26, 27, 28, 29, 30]),
        ],
      ),
    );
  }

  Widget _buildCalendarWeek(BuildContext context, List<int?> days, {int highlightStart = -1, int highlightEnd = -1}) {
    final colors = AppColorScheme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: days.map((day) {
          if (day == null) return const SizedBox(width: 28, height: 24);
          final attended = attendedDays.contains(day);
          return Container(
            width: 28,
            height: 24,
            decoration: BoxDecoration(
              color: attended ? AppColors.accent : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Text('$day',
                  style: TextStyle(
                    color: attended ? Colors.black : colors.textPrimary.withOpacity(0.6),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  )),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _GoalCard extends StatelessWidget {
  final int percent;
  const _GoalCard({required this.percent});

  @override
  Widget build(BuildContext context) {
    final colors = AppColorScheme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.inputBorder),
      ),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 52, height: 52,
                child: CircularProgressIndicator(
                  value: percent / 100,
                  backgroundColor: colors.inputBorder,
                  valueColor: const AlwaysStoppedAnimation<Color>(AppColors.accent),
                  strokeWidth: 5,
                ),
              ),
              Text('$percent%',
                  style: TextStyle(color: colors.textPrimary, fontSize: 11, fontWeight: FontWeight.w800)),
            ],
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('OBJETIVO MENSUAL',
                  style: TextStyle(color: AppColors.accent, fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: 1)),
              const SizedBox(height: 4),
              Text('Ve 2 días adelantado', style: TextStyle(color: colors.textSecondary, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}

class _CommunityCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = AppColorScheme.of(context);
    return Container(
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(
          colors: [AppColors.accentBlue.withOpacity(0.2), colors.cardBackground],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        border: Border.all(color: colors.inputBorder),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 12, left: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(color: AppColors.accent, borderRadius: BorderRadius.circular(4)),
                  child: const Text('COMUNIDAD',
                      style: TextStyle(color: Colors.black, fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 1)),
                ),
                const SizedBox(height: 6),
                Text('NUEVOS DESAFÍOS DE JUNIO',
                    style: TextStyle(color: colors.textPrimary, fontSize: 15, fontWeight: FontWeight.w800)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
