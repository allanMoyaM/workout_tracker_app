---
tags: [feature, history]
status: demo
created: 2026-08-23
---

# Feature: History

Pantalla de historial de entrenamientos (tab 2). Muestra asistencia mensual, calendario y actividad reciente.

## Archivos

| Archivo | Ruta |
|---|---|
| View | `lib/ui/history/view/history_screen.dart` |
| ViewModel | `lib/ui/history/view_model/history_view_model.dart` |

## UI

| Widget | Descripción |
|---|---|
| `_AttendanceHeader` | Total sesiones / meta + % de consistencia |
| `_CalendarCard` | Calendario mensual con días asistidos marcados en naranja |
| Recent Activity | Lista de `WorkoutSession` recientes con duración y kcal |

## Estado (`HistoryViewModel`)

```dart
int totalSessions;           // 18
int targetSessions;          // 20
int consistencyPercent;      // 90
DateTime currentMonth;       // mes actual
Set<int> attendedDays;       // {1, 3, 5, 8, 10, 12, 15, 16, ...}
List<WorkoutSession> recentActivity;
```

Todos los datos son hardcodeados actualmente.

## `WorkoutSession` — estructura por fila de actividad

Cada fila muestra: nombre, fecha, duración en minutos, kcal, ícono por categoría.

Categorías: `strength` | `cardio` | `recovery`

## TODOs pendientes

- [ ] Cargar sesiones reales desde `WorkoutRepository` / `LocalStorageService`
- [ ] Navegación de mes con los chevrons del calendario
- [ ] Calcular consistencia desde sesiones reales
- [ ] Detalle de sesión al tocar una fila de actividad

## Relacionado

- [[WorkoutSession]] — Modelo de datos de cada entrada en el historial
- [[Data Flow]] — Repositorio pendiente de conectar
