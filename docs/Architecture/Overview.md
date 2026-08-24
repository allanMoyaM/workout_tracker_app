---
tags: [architecture, overview]
created: 2026-08-23
---

# Arquitectura — Overview

EnerGym sigue **Clean Architecture** dividida en 3 capas principales más la capa de presentación.

## Diagrama de Capas

```
┌─────────────────────────────────────────────┐
│                  UI Layer                   │
│  Views (StatelessWidget) + ViewModels       │
│  (ChangeNotifier via Provider)              │
├─────────────────────────────────────────────┤
│               Data Layer                    │
│  Repositories + Services (LocalStorage)     │
├─────────────────────────────────────────────┤
│              Domain Layer                   │
│  Models puros (Exercise, Workout, etc.)     │
└─────────────────────────────────────────────┘
```

## Estructura de carpetas

```
lib/
├── main.dart                  # Entry point
├── app.dart                   # MultiProvider root + MaterialApp
├── routing/router.dart        # Rutas nombradas
├── domain/models/             # Entidades de negocio
├── data/
│   ├── repositories/          # Abstracción de acceso a datos
│   └── services/              # Implementaciones (LocalStorageService)
└── ui/
    ├── core/                  # Temas, widgets compartidos, VMs globales
    ├── auth/                  # Feature: Login
    ├── shell/                 # Shell con IndexedStack
    ├── dashboard/             # Feature: Dashboard
    ├── workout_tracker/       # Feature: Entrenamiento activo
    ├── history/               # Feature: Historial
    ├── profile/               # Feature: Perfil
    ├── home/                  # Feature: Lista de rutinas
    └── workout/               # Feature: Editor de rutina
```

## Providers registrados en `app.dart`

```dart
MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => ThemeNotifier()),
    ChangeNotifierProvider(create: (_) => LocaleNotifier()),
    ChangeNotifierProvider(create: (_) => LoginViewModel()),
    ChangeNotifierProvider(create: (_) => DashboardViewModel()),
    ChangeNotifierProvider(create: (_) => WorkoutTrackerViewModel()),
    ChangeNotifierProvider(create: (_) => HistoryViewModel()),
    ChangeNotifierProvider(create: (_) => ProfileViewModel()),
  ],
  ...
)
```

## Relacionado

- [[MVVM]] — Cómo se implementa el patrón en cada feature
- [[Data Flow]] — Flujo de datos entre capas
- [[Navigation]] — Cómo se conectan las pantallas
