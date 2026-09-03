# Sử dụng Ubuntu làm base image
FROM ubuntu:22.04

# Thiết lập biến môi trường
ENV DEBIAN_FRONTEND=noninteractive
ENV FLUTTER_HOME=/opt/flutter
ENV PATH="$FLUTTER_HOME/bin:$PATH"

# Cài đặt dependencies
RUN apt-get update && apt-get install -y \
    curl git unzip xz-utils zip libglu1-mesa wget ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Clone Flutter SDK (stable)
RUN git clone https://github.com/flutter/flutter.git -b stable $FLUTTER_HOME

# Enable Flutter web
RUN flutter config --enable-web

# Pre-cache web artifacts để build nhanh hơn
RUN flutter precache --web

# Kiểm tra cài đặt
RUN flutter doctor -v

# Đặt thư mục làm việc
WORKDIR /app

# Copy source code Flutter vào container
COPY . .

# Get packages
RUN flutter pub get
RUN flutter pub run build_runner build --delete-conflicting-outputs
# Build Flutter web release
RUN flutter build web --release --target lib/root/main.dart

# Expose port để chạy web server nếu muốn preview
EXPOSE 8080

# Dùng web server của Flutter để serve app (chỉ để test, không nên dùng production)
CMD ["flutter", "run", "-d", "web-server", "--web-port=8080", "--release"]
