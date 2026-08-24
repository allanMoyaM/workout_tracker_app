---
tags: [ui, i18n, localization]
created: 2026-08-23
---

# Localización (i18n)

EnerGym soporta inglés y español usando el sistema oficial de Flutter (`flutter_localizations` + ARB + codegen).

## Archivos clave

| Archivo | Propósito |
|---|---|
| `lib/l10n/app_en.arb` | Strings en inglés (fuente de verdad) |
| `lib/l10n/app_es.arb` | Traducciones al español |
| `l10n.yaml` | Configuración del codegen |
| `lib/ui/core/view_model/locale_notifier.dart` | Estado del idioma activo |

## `l10n.yaml`

```yaml
arb-dir: lib/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart
```

## `LocaleNotifier`

```dart
class LocaleNotifier extends ChangeNotifier {
  Locale _locale = const Locale('en'); // Inglés por defecto
  Locale get locale => _locale;
  bool get isEnglish => _locale.languageCode == 'en';
  
  void toggle() {
    _locale = isEnglish ? const Locale('es') : const Locale('en');
    notifyListeners();
  }
}
```

## Uso en widgets

```dart
final l10n = AppLocalizations.of(context)!;
Text(l10n.logIn)
Text(l10n.repsAt(vm.targetReps, vm.targetWeightKg.toInt()))
```

## Strings parametrizados

```json
"repsAt": "{reps} REPS @ {weight}kg",
"remaining": "{count} REMAINING",
"targetWeight": "Target Weight: {weight}kg",
"weeklySession": "Weekly Session: {done}/{target}"
```

## Locales soportados

| Código | Idioma |
|---|---|
| `en` | Inglés (default) |
| `es` | Español |

## Agregar un nuevo idioma

1. Crear `lib/l10n/app_{codigo}.arb` con las traducciones
2. Agregar `Locale('{codigo}')` a `supportedLocales` en `app.dart`
3. Correr `flutter gen-l10n`

## Relacionado

- [[Profile]] — Toggle de idioma EN/ES en App Preferences
- [[ADR-003 Flutter Localizations]] — Decisión de usar el sistema oficial vs terceros
