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
## Run app:
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

## Remote server

1. Remote vào server bằng linux command
```bash
ssh <username>@<ip_address> -p <port>
```

2. Kiểm tra dung lượng server
```bash
df -h
```

## Docker
1. Dừng tất cả docker container
```bash
docker stop $(docker ps -aq)
```

2. Xoá all docker container:
```bash
docker system prune -a --volumes
```

## Run in iOS simulator

1. Open IOS simulator
```bash
open -a Simulator
```