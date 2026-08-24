---
tags: [feature, profile, settings]
status: demo
created: 2026-08-23
---

# Feature: Profile

Pantalla de perfil y preferencias (tab 3). La más compleja de las 4 tabs.

## Archivos

| Archivo | Ruta |
|---|---|
| View | `lib/ui/profile/view/profile_screen.dart` |
| ViewModel | `lib/ui/profile/view_model/profile_view_model.dart` |

## Secciones de la UI

### 1. User Card
Avatar + nombre + título + badges (rank y nivel).

### 2. Current Weight
Peso actual en KG (grande, naranja) + Height y BF% como chips.

### 3. Main Lift Progression
Barras de actividad semanal (7 barras, Mon–Sun).

### 4. Training Goals
Dos `LinearProgressIndicator`:
- Target Weight: `{weight}kg` → 76% progreso
- Weekly Sessions: `{done}/{target}` → calculado desde `UserProfile`
- Botón "UPDATE GOALS"

### 5. App Preferences

| Preferencia | Implementación |
|---|---|
| Notifications toggle | `ProfileViewModel.notificationsEnabled` |
| Dark Mode toggle | `ThemeNotifier.toggle()` |
| Language badge EN/ES | `LocaleNotifier.toggle()` |
| Sync Health Kit | placeholder (sin acción) |
| **Log Out** | `Navigator.pushReplacementNamed(context, '/')` |

## Estado (`ProfileViewModel`)

```dart
UserProfile profile;          // Hardcodeado: Alex Rodriguez, 84.5kg...
bool notificationsEnabled;    // toggle local
List<double> weeklyActivity;  // [0.4, 0.8, 0.6, 1.0, 0.5, 0.3, 0.7]
List<String> weekDays;        // ['M','T','W','T','F','S','S']
```

## Interacciones funcionales ya implementadas

- Dark Mode toggle → cambia todo el tema de la app en tiempo real
- Language toggle → cambia todos los strings EN ↔ ES en tiempo real
- Log Out → navega de vuelta a Login (reemplaza la ruta)

## TODOs pendientes

- [ ] Cargar perfil real desde base de datos
- [ ] Editar foto de perfil
- [ ] Conectar Health Kit (HealthKit en iOS, Health Connect en Android)
- [ ] Guardar preferencias en `SharedPreferences`
- [ ] Pantalla de edición de goals

## Relacionado

- [[UserProfile]] — Modelo de datos del perfil
- [[Theming]] — ThemeNotifier que se controla desde aquí
- [[Localization]] — LocaleNotifier que se controla desde aquí
- [[Navigation]] — Log Out usa pushReplacementNamed
