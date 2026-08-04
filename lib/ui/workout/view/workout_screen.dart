import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/workout_view_model.dart';
import '../../core/widgets/loading_indicator.dart';

class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutViewModel>(
      builder: (context, vm, _) {
        if (vm.isLoading) return const Scaffold(body: LoadingIndicator());

        final workout = vm.workout;
        if (workout == null) {
          return const Scaffold(body: Center(child: Text('Sin entrenamiento')));
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(workout.name),
            actions: [
              IconButton(
                icon: Icon(vm.isSaved ? Icons.check : Icons.save_outlined),
                onPressed: vm.save,
              ),
            ],
          ),
          body: workout.exercises.isEmpty
              ? const Center(child: Text('Agrega ejercicios con el botón +'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: workout.exercises.length,
                  itemBuilder: (context, index) {
                    final exercise = workout.exercises[index];
                    return Card(
                      child: ListTile(
                        title: Text(exercise.name),
                        subtitle: Text(
                          '${exercise.sets} series × ${exercise.reps} reps · ${exercise.weightKg} kg',
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: () => vm.removeExercise(exercise.id),
                        ),
                      ),
                    );
                  },
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.fitness_center),
          ),
        );
      },
    );
  }
}
