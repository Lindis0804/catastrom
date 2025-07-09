## A Flutter template

## Generate resource
1. Generate image with build runner
```bash
flutter packages pub run build_runner watch --delete-conflicting-outputs
```

2. Generate 'g.dart' file 
```bash
flutter pub run build_runner build --delete-conflicting-outputs
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

- Recreate Android folder
```bash
flutter create . --platforms=android
```
### Run app:
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

### Run flutter web by Chrome, tránh lỗi CORS
```bash
flutter run -d chrome --web-browser-flag "--disable-web-security" --web-browser-flag "--user-data-dir=/tmp/temp_chrome" --target  lib/root/main.dart --web-port=8080
```

## Run in iOS simulator

1. Open IOS simulator
```bash
open -a Simulator
```

2.
 - Mở Cài đặt > Cài đặt chung > Quản lý VPN & thiết bị > Ứng dụng của nhà phát triển 

## RUN ANDROID
1. Run flutter android:
```bash
flutter run -d <device_id> --target  lib/root/main.dart 
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

