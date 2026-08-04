import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/home_view_model.dart';
import '../../core/widgets/loading_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeViewModel>().loadWorkouts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Entrenamientos'),
        centerTitle: true,
      ),
      body: Consumer<HomeViewModel>(
        builder: (context, vm, _) {
          if (vm.isLoading) return const LoadingIndicator();

          if (vm.error != null) {
            return Center(child: Text(vm.error!));
          }

          if (vm.workouts.isEmpty) {
            return const Center(
              child: Text(
                'Aún no tienes entrenamientos.\nPresiona + para agregar uno.',
                textAlign: TextAlign.center,
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: vm.workouts.length,
            itemBuilder: (context, index) {
              final workout = vm.workouts[index];
              return Card(
                child: ListTile(
                  title: Text(workout.name),
                  subtitle: Text(
                    '${workout.exercises.length} ejercicios · ${workout.totalSets} series',
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () => vm.deleteWorkout(workout.id),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
