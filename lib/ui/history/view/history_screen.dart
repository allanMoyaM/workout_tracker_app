import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../view_model/history_view_model.dart';
import '../../../domain/models/workout_session.dart';
import '../../core/themes/app_colors.dart';
import '../../core/themes/app_color_scheme.dart';
import '../../core/widgets/energym_app_bar.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HistoryViewModel>();
    final colors = AppColorScheme.of(context);
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: colors.background,
      appBar: const EnerGymAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _AttendanceHeader(vm: vm, colors: colors, l10n: l10n),
            const SizedBox(height: 12),
            _CalendarCard(vm: vm, colors: colors, l10n: l10n),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(l10n.recentActivity,
                    style: TextStyle(color: colors.textSecondary, fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: 1.5)),
                Text(l10n.viewAll, style: const TextStyle(color: AppColors.accent, fontSize: 10, fontWeight: FontWeight.w700)),
              ],
            ),
            const SizedBox(height: 10),
            ...vm.recentActivity.map((s) => _ActivityRow(session: s, colors: colors, l10n: l10n)),
          ],
        ),
      ),
    );
  }
}

class _AttendanceHeader extends StatelessWidget {
  final HistoryViewModel vm;
  final AppColorScheme colors;
  final AppLocalizations l10n;
  const _AttendanceHeader({required this.vm, required this.colors, required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.inputBorder),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.monthlyAttendance,
                    style: TextStyle(color: colors.textSecondary, fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: 1)),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${vm.totalSessions}',
                        style: const TextStyle(color: AppColors.accent, fontSize: 40, fontWeight: FontWeight.w900),
                      ),
                      TextSpan(
                        text: ' / ${vm.targetSessions} ${l10n.sessions}',
                        style: TextStyle(color: colors.textSecondary, fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(l10n.consistency, style: TextStyle(color: colors.textSecondary, fontSize: 10, letterSpacing: 1)),
              const SizedBox(height: 4),
              Text('${vm.consistencyPercent}%',
                  style: TextStyle(color: colors.textPrimary, fontSize: 28, fontWeight: FontWeight.w900)),
            ],
          ),
        ],
      ),
    );
  }
}

class _CalendarCard extends StatelessWidget {
  final HistoryViewModel vm;
  final AppColorScheme colors;
  final AppLocalizations l10n;
  const _CalendarCard({required this.vm, required this.colors, required this.l10n});

  @override
  Widget build(BuildContext context) {
    final month = vm.currentMonth;
    final monthName = _monthName(month.month);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.inputBorder),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('$monthName ${month.year}',
                  style: TextStyle(color: colors.textPrimary, fontSize: 14, fontWeight: FontWeight.w700)),
              Row(
                children: [
                  Icon(Icons.chevron_left, color: colors.textSecondary, size: 20),
                  const SizedBox(width: 8),
                  Icon(Icons.chevron_right, color: colors.textSecondary, size: 20),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ['M', 'T', 'W', 'T', 'F', 'S', 'S']
                .map((d) => SizedBox(
                      width: 32,
                      child: Text(d,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: colors.textSecondary, fontSize: 11, fontWeight: FontWeight.w600)),
                    ))
                .toList(),
          ),
          const SizedBox(height: 8),
          ..._buildCalendarRows(month, vm.attendedDays),
        ],
      ),
    );
  }

  List<Widget> _buildCalendarRows(DateTime month, Set<int> attendedDays) {
    final firstDay = DateTime(month.year, month.month, 1);
    final startOffset = (firstDay.weekday - 1) % 7;
    final daysInMonth = DateUtils.getDaysInMonth(month.year, month.month);
    const today = 16;

    final cells = <int?>[...List.filled(startOffset, null)];
    for (int d = 1; d <= daysInMonth; d++) { cells.add(d); }
    while (cells.length % 7 != 0) { cells.add(null); }

    final rows = <Widget>[];
    for (int i = 0; i < cells.length; i += 7) {
      rows.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: cells.sublist(i, i + 7).map((day) {
            if (day == null) return const SizedBox(width: 32, height: 28);
            final attended = attendedDays.contains(day);
            final isToday = day == today;
            return Container(
              width: 32, height: 28,
              decoration: BoxDecoration(
                color: attended ? AppColors.accent : isToday ? AppColors.accent.withOpacity(0.2) : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: isToday && !attended ? Border.all(color: AppColors.accent) : null,
              ),
              child: Center(
                child: Text('$day',
                    style: TextStyle(
                      color: attended ? Colors.black : colors.textPrimary.withOpacity(0.7),
                      fontSize: 11, fontWeight: FontWeight.w600,
                    )),
              ),
            );
          }).toList(),
        ),
      ));
    }
    return rows;
  }

  String _monthName(int month) {
    const names = ['', 'JANUARY', 'FEBRUARY', 'MARCH', 'APRIL', 'MAY', 'JUNE',
        'JULY', 'AUGUST', 'SEPTEMBER', 'OCTOBER', 'NOVEMBER', 'DECEMBER'];
    return names[month];
  }
}

class _ActivityRow extends StatelessWidget {
  final WorkoutSession session;
  final AppColorScheme colors;
  final AppLocalizations l10n;
  const _ActivityRow({required this.session, required this.colors, required this.l10n});

  @override
  Widget build(BuildContext context) {
    final color = _categoryColor(session.category);
    final icon = _categoryIcon(session.category);
    final dateStr = _formatDate(session.dateTime);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.inputBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(session.name, style: TextStyle(color: colors.textPrimary, fontSize: 13, fontWeight: FontWeight.w700)),
                const SizedBox(height: 3),
                Text(dateStr, style: TextStyle(color: colors.textSecondary, fontSize: 11)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('${session.durationMinutes}M',
                  style: TextStyle(color: colors.textPrimary, fontSize: 14, fontWeight: FontWeight.w800)),
              Text('480 ${l10n.kcal}', style: const TextStyle(color: AppColors.accent, fontSize: 11, fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }

  Color _categoryColor(String c) {
    switch (c) {
      case 'cardio': return Colors.orangeAccent;
      case 'recovery': return AppColors.accentBlue;
      default: return AppColors.accent;
    }
  }

  IconData _categoryIcon(String c) {
    switch (c) {
      case 'cardio': return Icons.directions_run;
      case 'recovery': return Icons.self_improvement;
      default: return Icons.fitness_center;
    }
  }

  String _formatDate(DateTime dt) {
    const months = ['', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    return '${months[dt.month]} ${dt.day} • $h:$m ${dt.hour < 12 ? 'AM' : 'PM'}';
  }
}
