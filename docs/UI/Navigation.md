---
tags: [ui, navigation, routing]
created: 2026-08-23
---

# Navegación

EnerGym usa rutas nombradas gestionadas por `AppRouter`.

## Archivos

| Archivo | Ruta |
|---|---|
| Router | `lib/routing/router.dart` |
| Shell | `lib/ui/shell/view/shell_screen.dart` |

## Rutas definidas

| Ruta | Pantalla | Descripción |
|---|---|---|
| `/` | `LoginScreen` | Pantalla de login (ruta inicial) |
| `/home` | `ShellScreen` | Shell con bottom nav + 4 tabs |

## Shell (`ShellScreen`)

El shell usa `IndexedStack` para mantener el estado de cada tab:

```
ShellScreen (/home)
├── Tab 0: DashboardScreen
├── Tab 1: WorkoutTrackerScreen
├── Tab 2: HistoryScreen
└── Tab 3: ProfileScreen
```

`EnerGymBottomNav` controla el índice activo con `setState`.

## Log Out

Desde [[Profile]], el botón de Log Out usa:

```dart
Navigator.pushReplacementNamed(context, '/');
```

`pushReplacementNamed` elimina `/home` del stack, impidiendo volver con el botón back.

## TODOs pendientes

- [ ] Rutas para `HomeScreen` (lista de rutinas)
- [ ] Rutas para `WorkoutScreen` (editor de rutina)
- [ ] Deep links para notificaciones push
- [ ] Transiciones animadas entre pantallas

## Relacionado

- [[Login]] — Ruta de entrada `/`
- [[Profile]] — Logout navigation
- [[Overview]] — Cómo el shell encaja en la arquitectura
