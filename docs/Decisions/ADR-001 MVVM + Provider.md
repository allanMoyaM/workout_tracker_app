---
tags: [adr, architecture, decision]
created: 2026-08-23
---

# ADR-001: MVVM + Provider como patrón de estado

## Estado: Aceptado

## Contexto

Al inicio del proyecto se evaluaron varias opciones de gestión de estado para Flutter:

| Opción | Pros | Contras |
|---|---|---|
| **Provider + ChangeNotifier** | Oficial de Flutter, simple, sin boilerplate | Rebuild granularity manual |
| Riverpod | Más typesafe, sin context | Más curva de aprendizaje |
| BLoC | Separación clara events/states | Mucho boilerplate para una app pequeña |
| GetX | Simple, sin contexto | Mezcla routing + state + DI, anti-patterns |

## Decisión

Se eligió **Provider 6.1.2** con **ChangeNotifier** porque:
1. Es la solución recomendada por el equipo de Flutter para apps medianas
2. Integra bien con el patrón MVVM
3. Curva de aprendizaje baja
4. `MultiProvider` en `app.dart` da DI limpio

## Consecuencias

- Los ViewModels son `ChangeNotifier` — fácil de testear unitariamente
- Las Views son `StatelessWidget` — sin estado local
- `context.watch<T>()` en build, `context.read<T>()` en callbacks
- Si la app crece significativamente, migrar a Riverpod es un refactor natural

## Relacionado

- [[Overview]] — Cómo se registran los providers
- [[MVVM]] — Implementación del patrón
