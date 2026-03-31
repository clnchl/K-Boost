# K-Boost

Application Flutter d'apprentissage des langues.

## Prerequis

- Flutter SDK installe (version stable)
- Dart SDK (inclus avec Flutter)
- Android Studio ou VS Code
- Pour iOS (macOS uniquement): Xcode

## Demarrage rapide

1. Recuperer le projet
2. Installer les dependances
3. Lancer l'application

```bash
flutter pub get
flutter run
```

## Setup Windows (important)

Si tu clones ce repo sur Windows:

1. Verifier Flutter

```bash
flutter doctor -v
```

2. Accepter les licences Android

```bash
flutter doctor --android-licenses
```

3. Lancer un emulateur Android puis l'app

```bash
flutter emulators
flutter emulators --launch <emulator_id>
flutter run
```

4. Optionnel: lancer sur Windows desktop

```bash
flutter config --enable-windows-desktop
flutter run -d windows
```

## Compatibilite cross-platform

- Les fichiers locaux/generes sont ignores par Git.
- Les fins de ligne sont normalisees via `.gitattributes` pour eviter les conflits macOS/Windows.
- Les scripts Windows (`.bat`, `.cmd`, `.ps1`) gardent des fins de ligne CRLF.

## Tests

```bash
flutter test
```
