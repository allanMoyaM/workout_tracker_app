import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/profile_view_model.dart';
import '../../core/themes/app_colors.dart';
import '../../core/themes/app_color_scheme.dart';
import '../../core/view_model/theme_notifier.dart';
import '../../core/widgets/energym_app_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProfileViewModel>();
    final themeNotifier = context.watch<ThemeNotifier>();
    final colors = AppColorScheme.of(context);
    final p = vm.profile;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: const EnerGymAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User card
            _Card(colors: colors, child: Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: colors.inputBackground,
                      child: Icon(Icons.person, color: colors.textPrimary, size: 32),
                    ),
                    Positioned(
                      bottom: 0, right: 0,
                      child: Container(
                        width: 18, height: 18,
                        decoration: const BoxDecoration(color: AppColors.accent, shape: BoxShape.circle),
                        child: const Icon(Icons.edit, color: Colors.black, size: 11),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(p.name,
                          style: TextStyle(color: colors.textPrimary, fontSize: 16, fontWeight: FontWeight.w900)),
                      const SizedBox(height: 2),
                      Text(p.title,
                          style: const TextStyle(color: AppColors.accent, fontSize: 10, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          _Badge(label: p.badge, color: AppColors.accent),
                          const SizedBox(width: 8),
                          _Badge(label: 'LVL ${p.level}', color: AppColors.accentBlue),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )),
            const SizedBox(height: 12),
            // Weight + stats
            _Card(colors: colors, child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('CURRENT WEIGHT',
                    style: TextStyle(color: colors.textSecondary, fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: 1.5)),
                const SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('${p.weightKg.toInt()}',
                        style: const TextStyle(color: AppColors.accent, fontSize: 52, fontWeight: FontWeight.w900, height: 1)),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8, left: 4),
                      child: Text('KG', style: TextStyle(color: colors.textSecondary, fontSize: 18, fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _StatChip(label: 'HEIGHT', value: '${p.heightCm.toInt()} CM', colors: colors),
                    const SizedBox(width: 24),
                    _StatChip(label: 'BF %', value: '${p.bodyFatPercent}%', colors: colors),
                  ],
                ),
              ],
            )),
            const SizedBox(height: 12),
            // Weekly bars
            _Card(colors: colors, child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('MAIN LIFT PROGRESSION',
                    style: TextStyle(color: colors.textSecondary, fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: 1)),
                const SizedBox(height: 12),
                SizedBox(
                  height: 64,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(vm.weeklyActivity.length, (i) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 28,
                            height: 48 * vm.weeklyActivity[i],
                            decoration: BoxDecoration(color: AppColors.accent, borderRadius: BorderRadius.circular(4)),
                          ),
                          const SizedBox(height: 4),
                          Text(vm.weekDays[i],
                              style: TextStyle(color: colors.textSecondary, fontSize: 9)),
                        ],
                      );
                    }),
                  ),
                ),
              ],
            )),
            const SizedBox(height: 12),
            // Goals
            _Card(colors: colors, child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('TRAINING GOALS',
                    style: TextStyle(color: colors.textSecondary, fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: 1.5)),
                const SizedBox(height: 14),
                _GoalBar(
                  label: 'Target Weight: ${p.targetWeightKg.toInt()}kg',
                  percent: 0.76, percentLabel: '76%', colors: colors,
                ),
                const SizedBox(height: 12),
                _GoalBar(
                  label: 'Weekly Session: ${p.weeklySessionsDone}/${p.weeklySessionTarget}',
                  percent: p.weeklySessionProgress,
                  percentLabel: '${(p.weeklySessionProgress * 100).toInt()}%',
                  colors: colors,
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(color: AppColors.accent, borderRadius: BorderRadius.circular(10)),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.tune, color: Colors.black, size: 18),
                        SizedBox(width: 8),
                        Text('UPDATE GOALS',
                            style: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.w800, letterSpacing: 1)),
                      ],
                    ),
                  ),
                ),
              ],
            )),
            const SizedBox(height: 12),
            // Preferences
            _Card(colors: colors, child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('APP PREFERENCES',
                    style: TextStyle(color: colors.textSecondary, fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: 1.5)),
                const SizedBox(height: 12),
                _PrefToggle(
                  icon: Icons.notifications_outlined,
                  label: 'Notifications',
                  value: vm.notificationsEnabled,
                  onChanged: (_) => vm.toggleNotifications(),
                  colors: colors,
                ),
                _PrefToggle(
                  icon: Icons.dark_mode_outlined,
                  label: 'Dark Mode',
                  value: themeNotifier.isDark,
                  onChanged: (_) => context.read<ThemeNotifier>().toggle(),
                  colors: colors,
                ),
                _PrefRow(
                  icon: Icons.sync,
                  label: 'Sync Health Kit',
                  trailing: Icon(Icons.chevron_right, color: colors.textSecondary, size: 18),
                  colors: colors,
                ),
                Divider(color: colors.divider, height: 20),
                _PrefRow(
                  icon: Icons.logout,
                  label: 'Log Out',
                  iconColor: Colors.redAccent,
                  labelColor: Colors.redAccent,
                  trailing: const SizedBox.shrink(),
                  colors: colors,
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final Widget child;
  final AppColorScheme colors;
  const _Card({required this.child, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.inputBorder),
      ),
      child: child,
    );
  }
}

class _Badge extends StatelessWidget {
  final String label;
  final Color color;
  const _Badge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Text(label, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w800)),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final String value;
  final AppColorScheme colors;
  const _StatChip({required this.label, required this.value, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: colors.textSecondary, fontSize: 10, letterSpacing: 1)),
        const SizedBox(height: 2),
        Text(value, style: TextStyle(color: colors.textPrimary, fontSize: 14, fontWeight: FontWeight.w700)),
      ],
    );
  }
}

class _GoalBar extends StatelessWidget {
  final String label;
  final double percent;
  final String percentLabel;
  final AppColorScheme colors;
  const _GoalBar({required this.label, required this.percent, required this.percentLabel, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: TextStyle(color: colors.textPrimary.withOpacity(0.8), fontSize: 12)),
            Text(percentLabel, style: const TextStyle(color: AppColors.accent, fontSize: 12, fontWeight: FontWeight.w700)),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: percent,
            minHeight: 6,
            backgroundColor: colors.inputBorder,
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.accent),
          ),
        ),
      ],
    );
  }
}

class _PrefToggle extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  final AppColorScheme colors;
  const _PrefToggle({required this.icon, required this.label, required this.value, required this.onChanged, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: colors.textSecondary, size: 18),
          const SizedBox(width: 12),
          Expanded(child: Text(label, style: TextStyle(color: colors.textPrimary, fontSize: 13))),
          Switch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}

class _PrefRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget trailing;
  final AppColorScheme colors;
  final Color? iconColor;
  final Color? labelColor;
  const _PrefRow({required this.icon, required this.label, required this.trailing, required this.colors, this.iconColor, this.labelColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: iconColor ?? colors.textSecondary, size: 18),
          const SizedBox(width: 12),
          Expanded(child: Text(label, style: TextStyle(color: labelColor ?? colors.textPrimary, fontSize: 13))),
          trailing,
        ],
      ),
    );
  }
}
