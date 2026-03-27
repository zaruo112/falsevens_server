FROM ubuntu:22.04

# 必要なパッケージをインストール
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    libfontconfig1 \
    libgl1 \
    libegl1 \
    libgles2 \
    && rm -rf /var/lib/apt/lists/*

# Godot Linux ヘッドレスバイナリをダウンロード
ARG GODOT_VERSION=4.6.1
RUN wget -q "https://github.com/godotengine/godot/releases/download/${GODOT_VERSION}-stable/Godot_v${GODOT_VERSION}-stable_linux.x86_64.zip" \
    -O /tmp/godot.zip && \
    unzip /tmp/godot.zip -d /usr/local/bin/ && \
    mv /usr/local/bin/Godot_v${GODOT_VERSION}-stable_linux.x86_64 /usr/local/bin/godot && \
    chmod +x /usr/local/bin/godot && \
    rm /tmp/godot.zip

# サーバー用エクスポートファイルをコピー
WORKDIR /app
COPY server.pck /app/server.pck

# ポート8080を公開
EXPOSE 8080

# ヘッドレスサーバーとして起動
CMD ["godot", "--headless", "--main-pack", "/app/server.pck", "--main-scene", "res://scenes/server/ServerMain.tscn"]
