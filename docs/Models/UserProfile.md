---
tags: [model, domain]
created: 2026-08-23
---

# Modelo: UserProfile

Datos del perfil del usuario. Incluye stats físicos, metas y progreso semanal.

**Ruta:** `lib/domain/models/user_profile.dart`

## Campos

| Campo | Tipo | Descripción |
|---|---|---|
| `name` | `String` | Nombre completo |
| `title` | `String` | Título (ej. "ELITE ATHLETE") |
| `badge` | `String` | Rango (ej. "GOLD") |
| `level` | `int` | Nivel numérico |
| `weightKg` | `double` | Peso actual |
| `heightCm` | `double` | Altura en cm |
| `bodyFatPercent` | `double` | % de grasa corporal |
| `targetWeightKg` | `double` | Peso objetivo |
| `weeklySessionTarget` | `int` | Sesiones por semana objetivo |
| `weeklySessionsDone` | `int` | Sesiones completadas esta semana |

## Computed properties

```dart
double get weightGoalProgress => weightKg / targetWeightKg;

double get weeklySessionProgress =>
    weeklySessionsDone / weeklySessionTarget;
```

## Datos demo actuales

```
Nombre: Alex Rodriguez
Peso: 84.5 kg  |  Meta: 80 kg
Altura: 181 cm  |  BF: 14.2%
Sesiones: 3/4 esta semana
Badge: GOLD  |  Nivel: 42
```

## Relacionado

- [[Profile]] — Feature que muestra y edita este modelo
- [[TODOs]] — Carga desde base de datos pendiente
