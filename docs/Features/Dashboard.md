---
tags: [feature, dashboard]
status: demo
created: 2026-08-23
---

# Feature: Dashboard

Pantalla principal de la app (tab 0). Muestra métricas de entrenamiento del usuario.

## Archivos

| Archivo | Ruta |
|---|---|
| View | `lib/ui/dashboard/view/dashboard_screen.dart` |
| ViewModel | `lib/ui/dashboard/view_model/dashboard_view_model.dart` |

## Secciones de la UI

| Widget | Descripción |
|---|---|
| Greeting card | Saludo con motivación del día |
| Streak card | Racha de días de entrenamiento consecutivos |
| Start Workout button | Botón CTA naranja |
| Info cards | Last Workout, Next Session |
| Attendance card | Asistencia mensual vs meta |
| Community card | Challenges del mes |

## Estado (`DashboardViewModel`)

Todos los datos son **hardcodeados** (demo). No usa repositorio.

```dart
int get streakDays => 14;
int get attendanceCount => 18;
int get attendanceTarget => 20;
String get lastWorkout => 'Push Day A';
String get nextSession => 'Legs & Core';
```

## TODOs pendientes

- [ ] Conectar a `WorkoutRepository` para streak real
- [ ] Calcular asistencia desde `WorkoutSession` histórico
- [ ] Cargar próxima sesión desde el plan del usuario

## Relacionado

- [[WorkoutSession]] — Fuente de datos para historial y asistencia
- [[Workout Tracker]] — Pantalla que se inicia desde el botón "Start Workout"
