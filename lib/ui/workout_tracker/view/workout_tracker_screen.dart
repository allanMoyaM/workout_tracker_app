import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/workout_tracker_view_model.dart';
import '../../core/themes/app_colors.dart';
import '../../core/themes/app_color_scheme.dart';
import '../../core/widgets/energym_app_bar.dart';

class WorkoutTrackerScreen extends StatelessWidget {
  const WorkoutTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<WorkoutTrackerViewModel>();
    final colors = AppColorScheme.of(context);
    return Scaffold(
      backgroundColor: colors.background,
      appBar: const EnerGymAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('CURRENT EXERCISE',
                style: TextStyle(color: colors.textSecondary, fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: 1.5)),
            const SizedBox(height: 6),
            Text(vm.currentExercise,
                style: TextStyle(color: colors.textPrimary, fontSize: 22, fontWeight: FontWeight.w900)),
            const SizedBox(height: 16),
            _StatCard(colors: colors, child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text('REST (SEC.)', style: TextStyle(color: colors.textSecondary, fontSize: 10, letterSpacing: 1)),
                      const SizedBox(height: 4),
                      Text(vm.restFormatted,
                          style: const TextStyle(color: AppColors.accent, fontSize: 28, fontWeight: FontWeight.w900)),
                    ],
                  ),
                ),
                Container(width: 1, height: 40, color: colors.inputBorder),
                Expanded(
                  child: Column(
                    children: [
                      Text('VELOC.', style: TextStyle(color: colors.textSecondary, fontSize: 10, letterSpacing: 1)),
                      const SizedBox(height: 4),
                      Text('${vm.velocity} m/s',
                          style: TextStyle(color: colors.textPrimary, fontSize: 22, fontWeight: FontWeight.w900)),
                    ],
                  ),
                ),
              ],
            )),
            const SizedBox(height: 12),
            _StatCard(colors: colors, child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('SERIES', style: TextStyle(color: colors.textSecondary, fontSize: 10, letterSpacing: 1)),
                      const SizedBox(height: 4),
                      Text('SET ${vm.currentSet} / ${vm.totalSets}',
                          style: TextStyle(color: colors.textPrimary, fontSize: 20, fontWeight: FontWeight.w900)),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('TARGET', style: TextStyle(color: colors.textSecondary, fontSize: 10, letterSpacing: 1)),
                    const SizedBox(height: 4),
                    Text('${vm.targetReps} REPS @ ${vm.targetWeightKg.toInt()}kg',
                        style: TextStyle(color: colors.textPrimary, fontSize: 14, fontWeight: FontWeight.w700)),
                  ],
                ),
              ],
            )),
            const SizedBox(height: 12),
            _CounterCard(
              label: 'WEIGHT (KG)',
              value: vm.weightKg % 1 == 0 ? vm.weightKg.toInt().toString() : vm.weightKg.toString(),
              onDecrement: vm.decrementWeight,
              onIncrement: vm.incrementWeight,
              colors: colors,
            ),
            const SizedBox(height: 12),
            _CounterCard(
              label: 'REPETITIONS',
              value: '${vm.reps}',
              onDecrement: vm.decrementReps,
              onIncrement: vm.incrementReps,
              colors: colors,
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: vm.completeSet,
              child: Container(
                height: 56,
                decoration: BoxDecoration(color: AppColors.accent, borderRadius: BorderRadius.circular(12)),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle_outline, color: Colors.black, size: 20),
                    SizedBox(width: 10),
                    Text('COMPLETE SET',
                        style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w800, letterSpacing: 1.5)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('UPCOMING EXERCISES',
                    style: TextStyle(color: colors.textSecondary, fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: 1.5)),
                const Text('${3} REMAINING',
                    style: TextStyle(color: AppColors.accent, fontSize: 10, fontWeight: FontWeight.w700)),
              ],
            ),
            const SizedBox(height: 10),
            ...vm.upcoming.map((e) => _UpcomingExerciseRow(exercise: e, colors: colors)),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final Widget child;
  final AppColorScheme colors;
  const _StatCard({required this.child, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.inputBorder),
      ),
      child: child,
    );
  }
}

class _CounterCard extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;
  final AppColorScheme colors;

  const _CounterCard({
    required this.label,
    required this.value,
    required this.onDecrement,
    required this.onIncrement,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.inputBorder),
      ),
      child: Column(
        children: [
          Text(label, style: TextStyle(color: colors.textSecondary, fontSize: 10, letterSpacing: 1.5)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _CircleButton(icon: Icons.remove, onTap: onDecrement, colors: colors),
              Text(value,
                  style: const TextStyle(color: AppColors.accent, fontSize: 48, fontWeight: FontWeight.w900)),
              _CircleButton(icon: Icons.add, onTap: onIncrement, colors: colors),
            ],
          ),
        ],
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final AppColorScheme colors;
  const _CircleButton({required this.icon, required this.onTap, required this.colors});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44, height: 44,
        decoration: BoxDecoration(
          color: colors.inputBackground,
          shape: BoxShape.circle,
          border: Border.all(color: colors.inputBorder),
        ),
        child: Icon(icon, color: colors.textPrimary, size: 20),
      ),
    );
  }
}

class _UpcomingExerciseRow extends StatelessWidget {
  final UpcomingExercise exercise;
  final AppColorScheme colors;
  const _UpcomingExerciseRow({required this.exercise, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: colors.inputBorder),
      ),
      child: Row(
        children: [
          Text('0${exercise.number}',
              style: TextStyle(color: colors.textSecondary, fontSize: 12, fontWeight: FontWeight.w700)),
          const SizedBox(width: 16),
          Expanded(child: Text(exercise.name,
              style: TextStyle(color: colors.textPrimary, fontSize: 14, fontWeight: FontWeight.w600))),
          Icon(Icons.drag_handle, color: colors.textSecondary, size: 18),
        ],
      ),
    );
  }
}
