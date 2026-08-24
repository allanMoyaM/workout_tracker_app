---
tags: [development, setup]
created: 2026-08-23
---

# Setup del Proyecto

## Prerrequisitos

- Flutter SDK >= 3.4.3
- Dart >= 3.4.3
- Xcode (para iOS)
- Android Studio / emulador Android

## Correr el proyecto

```bash
# Instalar dependencias
flutter pub get

# Generar código de localización
flutter gen-l10n

# Correr en iOS Simulator
flutter run -d <DEVICE_ID>

# Obtener lista de dispositivos disponibles
flutter devices
```

## Correr tests

```bash
flutter test
```

## Estructura de comandos frecuentes

```bash
# Ver análisis de código
flutter analyze

# Formatear código
dart format lib/

# Limpiar build
flutter clean && flutter pub get
```

## Variables de entorno

Actualmente no hay variables de entorno. Al agregar Firebase o APIs externas, usar `flutter_dotenv` o `--dart-define`.

## Plataformas soportadas

| Plataforma | Estado |
|---|---|
| iOS | ✓ Principal |
| Android | ✓ Soportado |
| Web | ✓ Configurado |
| macOS | ✓ Configurado |
| Windows | ✓ Configurado |
| Linux | ✓ Configurado |

## Relacionado

- [[Roadmap]] — Qué viene después
- [[TODOs]] — Items pendientes en el código
