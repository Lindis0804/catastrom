# cấu trúc thư mục cần thiết
# project-root/
# ├── lib/
# ├── web/
# ├── pubspec.yaml
# ├── pubspec.lock
# └── Dockerfile

# Base image with Flutter SDK
FROM cirrusci/flutter:stable

# Set working directory
WORKDIR /app

# Copy the rest of the app source code
COPY . .

# Copy pubspec files and install dependencies first (to leverage Docker cache)
COPY pubspec.yaml pubspec.lock ./

# Cấu hình Git để tránh lỗi "dubious ownership"
RUN git config --global --add safe.directory /sdks/flutter

# Tạo user mới không dùng root
RUN adduser --disabled-password flutteruser

# Cấp quyền cho user mới với thư mục flutter SDK
RUN chown -R flutteruser:flutteruser /sdks /app

# Chuyển sang user không phải root
USER flutteruser

RUN flutter pub get

# Enable web support
## RUN flutter config --enable-web

# Build the Flutter web app (default to release mode)
RUN flutter build web

# Optional: use Nginx to serve the build
FROM nginx:alpine
COPY --from=0 /app/build/web /usr/share/nginx/html

# Expose default Nginx port
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
