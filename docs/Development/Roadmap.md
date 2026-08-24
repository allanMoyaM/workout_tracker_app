---
tags: [development, roadmap]
created: 2026-08-23
---

# Roadmap

Features y mejoras pendientes organizadas por prioridad.

## Alta prioridad

### Persistencia de datos
- [ ] Migrar `LocalStorageService` de in-memory a SQLite (via `sqflite`) o Hive
- [ ] Guardar `WorkoutSession` al completar una sesión de [[Workout Tracker]]
- [ ] Persistir preferencias (notificaciones, idioma, dark mode) con `SharedPreferences`

### Autenticación real
- [ ] Firebase Auth o Supabase como backend
- [ ] Google Sign In
- [ ] Apple Sign In
- [ ] Manejo de sesión (token refresh, logout limpio)

### Conectar datos reales a las pantallas
- [ ] [[Dashboard]] — streak y asistencia desde sesiones reales
- [ ] [[History]] — calendario desde `WorkoutSession` guardadas
- [ ] [[Profile]] — perfil desde base de datos del usuario

## Media prioridad

### Workout Tracker
- [ ] Rest timer funcional con `Timer.periodic`
- [ ] Navegar al siguiente ejercicio automáticamente al completar el set
- [ ] Finalizar sesión: resumen + guardar `WorkoutSession`

### Cobertura de tests
- [ ] Tests unitarios para ViewModels
- [ ] Tests de integración para `WorkoutRepository`
- [ ] Widget tests por pantalla

### Navegación
- [ ] Rutas para `HomeScreen` (lista de rutinas CRUD)
- [ ] Rutas para `WorkoutScreen` (editor de rutina)
- [ ] Deep links

## Baja prioridad / Futuro

- [ ] Sync con Apple Health Kit (iOS) y Health Connect (Android)
- [ ] Push notifications para recordatorios de entrenamiento
- [ ] Foto de perfil con image picker
- [ ] Idiomas adicionales (PT, FR)
- [ ] Modo offline con sync posterior
- [ ] Gráficas de progreso de levantamientos con `fl_chart`
- [ ] Comunidad y challenges en tiempo real

## Relacionado

- [[TODOs]] — Items específicos encontrados en el código
- [[Data Flow]] — Arquitectura de datos actual
- [[Setup]] — Cómo correr el proyecto
