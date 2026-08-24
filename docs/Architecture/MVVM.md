---
tags: [architecture, mvvm, provider]
created: 2026-08-23
---

# Patrón MVVM

EnerGym usa **MVVM (Model-View-ViewModel)** implementado con el paquete `provider`.

## Roles

| Capa | Responsabilidad | Implementación |
|---|---|---|
| **Model** | Datos y lógica de negocio | `domain/models/*.dart` |
| **ViewModel** | Estado de UI + orquestación | `*_view_model.dart` (ChangeNotifier) |
| **View** | Renderizado declarativo | `*_screen.dart` (StatelessWidget) |

## Anatomía de un ViewModel

```dart
class WorkoutTrackerViewModel extends ChangeNotifier {
  // Estado
  int _reps = 8;
  int get reps => _reps;

  // Mutación — siempre termina en notifyListeners()
  void incrementReps() {
    _reps++;
    notifyListeners();
  }
}
```

## Anatomía de una View

```dart
class WorkoutTrackerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Suscribirse a cambios
    final vm = context.watch<WorkoutTrackerViewModel>();

    // Leer sin suscribirse (para callbacks)
    // context.read<WorkoutTrackerViewModel>().incrementReps()

    return Text('${vm.reps}');
  }
}
```

## Convenciones del proyecto

- Las Views son siempre `StatelessWidget` — el estado vive en el ViewModel.
- `context.watch<T>()` en `build()` para reactive UI.
- `context.read<T>()` dentro de callbacks (no en build) para evitar rebuilds innecesarios.
- Los ViewModels no conocen el contexto de Flutter — son Dart puro con ChangeNotifier.
- Los VMs globales (`ThemeNotifier`, `LocaleNotifier`) se registran en `app.dart` y viven toda la sesión.

## Relacionado

- [[Overview]] — Dónde encaja MVVM en la arquitectura general
- [[Data Flow]] — Cómo los ViewModels interactúan con repositorios
