FROM debian:bookworm-slim

# 安装所有必要的依赖
RUN apt-get update \
    && apt-get install -y gcc g++ libc6-dev pkg-config libssl3 wget protobuf-compiler \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# 只复制需要的文件
COPY target/release/anda_bot /app/
COPY target/release/Character.toml /app/
COPY target/release/Config.toml /app/
COPY target/release/.env /app/

# 创建数据目录
RUN mkdir -p /app/object_store

# 暴露端口
EXPOSE 8080

CMD ["./anda_bot", "start-local"]