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

## Publicación en tiendas

> Requisito previo: Fase 1 (auth real) debe estar completa antes de someter a revisión.

### Costos
| Tienda | Costo |
|---|---|
| App Store (iOS) | $99 USD/año — Apple Developer Program |
| Google Play | $25 USD — pago único |

### App Store (iOS)
- [ ] Registrarse en Apple Developer Program ($99/año)
- [ ] Crear App ID y provisioning profiles en Apple Developer Portal
- [ ] Configurar íconos, splash screen y metadata de la app
- [ ] Redactar Privacy Policy (obligatoria si hay auth o datos de usuario)
- [ ] Configurar App Store Connect: descripción, capturas de pantalla, categoría
- [ ] Build de release con Xcode: `flutter build ipa`
- [ ] Subir con Xcode o Transporter y pasar App Review (1–3 días hábiles)

### Google Play (Android)
- [ ] Registrarse en Google Play Console ($25 único)
- [ ] Generar keystore de release: `keytool -genkey ...`
- [ ] Build de release: `flutter build appbundle`
- [ ] Crear ficha en Play Console: descripción, capturas, categoría
- [ ] Redactar Privacy Policy
- [ ] Someter a revisión (generalmente más rápido que Apple)

### Checklist general pre-publicación
- [ ] Auth real funcionando (Fase 1 completada)
- [ ] Sin datos hardcodeados visibles al usuario
- [ ] Privacy Policy publicada en URL accesible
- [ ] Íconos en todas las resoluciones (usar `flutter_launcher_icons`)
- [ ] Splash screen configurado (usar `flutter_native_splash`)
- [ ] Versión y build number actualizados en `pubspec.yaml`
- [ ] Probar en dispositivo físico iOS y Android (no solo simulador)
- [ ] Crash-free rate > 99% en pruebas

## Relacionado

- [[TODOs]] — Items específicos encontrados en el código
- [[Data Flow]] — Arquitectura de datos actual
- [[Setup]] — Cómo correr el proyecto
