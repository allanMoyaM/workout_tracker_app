---
tags: [ui, theming, colors]
created: 2026-08-23
---

# Sistema de Temas

EnerGym tiene soporte completo de dark/light mode con Material 3.

## Archivos

| Archivo | Ruta |
|---|---|
| Colores constantes | `lib/ui/core/themes/app_colors.dart` |
| Paleta semántica | `lib/ui/core/themes/app_color_scheme.dart` |
| Configuración de tema | `lib/ui/core/themes/app_theme.dart` |
| Notifier | `lib/ui/core/view_model/theme_notifier.dart` |

## Colores de marca (`AppColors`)

```dart
static const Color accent = Color(0xFFF5A520);      // Naranja EnerGym
static const Color accentBlue = Color(0xFF1565C0);  // Azul secundario
```

## Paleta semántica (`AppColorScheme`)

8 roles de color que cambian entre dark y light:

| Rol | Dark | Light |
|---|---|---|
| `background` | `#0D1420` | `#F2F5F9` |
| `cardBackground` | `#131C2E` | `#FFFFFF` |
| `textPrimary` | `#FFFFFF` | `#0D1420` |
| `textSecondary` | `#8A9BB5` | `#6B7A8D` |
| `inputBackground` | `#1A2440` | `#EEF1F6` |
| `inputBorder` | `#2A3A5C` | `#DDE2EC` |
| `divider` | `#1F2D45` | `#E8ECF3` |
| `surface` | `#1A2440` | `#F8FAFC` |

## Uso en widgets

```dart
// Acceder a la paleta semántica
final colors = AppColorScheme.of(context);

// Usar colores
Container(color: colors.cardBackground)
Text('Hola', style: TextStyle(color: colors.textPrimary))
```

## Cambio de tema

El toggle vive en [[Profile]] → App Preferences → Dark Mode.

```dart
// ThemeNotifier
void toggle() {
  _mode = isDark ? ThemeMode.light : ThemeMode.dark;
  notifyListeners();
}
```

El `MaterialApp` en `app.dart` escucha `ThemeNotifier` via `Consumer2`.

## Relacionado

- [[Profile]] — Donde el usuario cambia el tema
- [[ADR-001 MVVM + Provider]] — Por qué ThemeNotifier es un ChangeNotifier global
