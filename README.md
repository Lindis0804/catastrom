## A Flutter template

## Generated with build runner
```bash
flutter packages pub run build_runner watch --delete-conflicting-outputs
```

## How to run Flutter app?
- Clone github repo: 
```bash
git clone 
```
- Install package
```bash
flutter pub get
```
### Run app:
- Run web:
```
flutter run --target lib/root/main.dart
```
### Run app in debug mode:
- Ctrl + Shift + D to open VSCode in debug mode.
- Press play button.

### Generate reference-assets code
```bash
flutter pub run build_runner build
```

### Run flutter web
```bash
flutter run -d web-server --target  lib/root/main.dart --web-port=<PORT>
```

## Config git LOCAL profile:
```bash
git config user.name "<username>"
git config user.email "<useremail>"
```

## Check git profile
```bash
git config --list
```