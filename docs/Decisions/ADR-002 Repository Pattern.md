---
tags: [adr, architecture, decision, data]
created: 2026-08-23
---

# ADR-002: Repository Pattern para acceso a datos

## Estado: Aceptado

## Contexto

Los ViewModels necesitan acceder a datos (rutinas, sesiones, perfil). Se evaluó:

1. **Acceso directo a servicios** desde el ViewModel — simple pero acoplado
2. **Repository Pattern** — abstracción entre VM y fuente de datos
3. **UseCase/Interactor** — capa extra de dominio

## Decisión

Se usa **Repository Pattern** con un nivel de abstracción:

```
ViewModel → Repository → Service (LocalStorageService)
```

Sin capa de UseCase por ahora, dado el tamaño del proyecto.

## Beneficios

- El ViewModel no sabe si los datos vienen de SQLite, API, o memoria
- Cambiar `LocalStorageService` por SQLite no afecta a los ViewModels
- Fácil de mockear en tests

## Consecuencias

- `WorkoutRepository` es el único punto de acceso a datos de rutinas
- `LocalStorageService` es la implementación concreta actual (in-memory)
- Pendiente: inyectar el repositorio como dependencia en lugar de instanciarlo en el ViewModel

## Relacionado

- [[Data Flow]] — Diagrama completo del flujo
- [[TODOs]] — Migración a SQLite pendiente
