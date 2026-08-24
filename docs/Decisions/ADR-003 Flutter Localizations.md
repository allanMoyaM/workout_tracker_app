---
tags: [adr, i18n, decision]
created: 2026-08-23
---

# ADR-003: Flutter Localizations (oficial) para i18n

## Estado: Aceptado

## Contexto

Para agregar soporte EN/ES se evaluaron:

| Opción | Pros | Contras |
|---|---|---|
| **flutter_localizations + ARB** | Oficial, type-safe, codegen | Requiere `flutter gen-l10n` |
| `easy_localization` | Más simple, JSON | Dependencia de tercero, strings como `String` |
| `intl_utils` | Codegen también | Similar al oficial pero de tercero |
| Hardcoded + switch | Cero setup | No escala, anti-pattern |

## Decisión

Se eligió el **sistema oficial de Flutter** (`flutter_localizations` + archivos ARB + codegen) porque:
1. No agrega dependencias de terceros
2. Los strings son **type-safe** (métodos generados, no strings mágicos)
3. Soporte nativo de strings parametrizados con tipos
4. Integra con el sistema de `Locale` de Flutter

## Implementación

- `lib/l10n/app_en.arb` — fuente de verdad (inglés)
- `lib/l10n/app_es.arb` — traducciones
- `l10n.yaml` — configuración
- `LocaleNotifier` — gestiona el `Locale` activo como ChangeNotifier global
- `Consumer2<ThemeNotifier, LocaleNotifier>` envuelve `MaterialApp`

## Consecuencias

- Hay que correr `flutter gen-l10n` al agregar nuevos strings
- Los strings son `l10n.keyName` — si falta una key en el `.arb`, hay error de compilación
- Agregar idiomas nuevos es solo crear un nuevo `.arb` y agregar `Locale` a `supportedLocales`

## Relacionado

- [[Localization]] — Documentación de uso
- [[Profile]] — Toggle de idioma en la app
