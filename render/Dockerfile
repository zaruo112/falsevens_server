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

# Godotバイナリをダウンロード（使用バージョンに合わせて変更）
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

# Render.com環境ではHTTPプロキシ経由のためWebSocketMultiplayerPeerを使用する
# Fly.io等の直接TCP環境では設定不要（デフォルトはTCPServer方式）
ENV USE_WS_SERVER=0

# ポートはRender.comが環境変数PORTで動的に指定する
EXPOSE 8080

# ヘッドレスサーバーとして起動
CMD ["godot", "--headless", "--main-pack", "/app/server.pck", "--main-scene", "res://scenes/server/ServerMain.tscn"]
