---
tags: [index, energym]
created: 2026-08-23
---

# EnerGym — Workout Tracker

Bienvenido a la vault de documentación de **EnerGym**, una app de seguimiento de entrenamientos construida con Flutter.

---

## Secciones

### Arquitectura
- [[Overview]] — Capas del sistema y flujo general
- [[MVVM]] — Patrón MVVM con Provider
- [[Data Flow]] — Cómo viaja la data de repositorio a vista

### Features (Pantallas)
- [[Login]] — Autenticación
- [[Dashboard]] — Pantalla principal con métricas
- [[Workout Tracker]] — Sesión activa de entrenamiento
- [[History]] — Historial y calendario de asistencia
- [[Profile]] — Perfil, estadísticas y preferencias

### Modelos de Dominio
- [[Exercise]] — Entidad de ejercicio
- [[Workout]] — Entidad de rutina
- [[WorkoutSession]] — Sesión completada
- [[UserProfile]] — Perfil del usuario

### UI
- [[Theming]] — Sistema de colores y temas dark/light
- [[Localization]] — Soporte multiidioma EN/ES
- [[Navigation]] — Rutas y estructura de navegación

### Desarrollo
- [[Setup]] — Cómo correr el proyecto
- [[Roadmap]] — Features pendientes
- [[TODOs]] — Pendientes encontrados en el código

### Decisiones Técnicas
- [[ADR-001 MVVM + Provider]]
- [[ADR-002 Repository Pattern]]
- [[ADR-003 Flutter Localizations]]

---

## Stack

| Capa | Tecnología |
|---|---|
| UI | Flutter 3.x, Material 3 |
| State | Provider 6.1.2 (ChangeNotifier) |
| i18n | flutter_localizations + ARB |
| Arquitectura | MVVM + Clean Architecture |
| Plataformas | iOS, Android, Web, Desktop |
