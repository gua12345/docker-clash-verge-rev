FROM gua12345/docker_novnc:latest

# 显式使用 root 用户，确保有足够的权限
USER root

ENV TITLE="Clash Verge"

# 更新 apt 并安装必需的包
RUN apt-get update && apt-get install -y \
        wget \
        curl \
        ca-certificates \
        libglib2.0-0 \
        libsm6 \
        libxrender1 \
        libfontconfig1 \
        dpkg \
        && rm -rf /var/lib/apt/lists/*
        
# 安装 Clash Verge 的依赖包
RUN apt-get update && apt-get install -y --no-install-recommends \
    libayatana-appindicator3-1 \
    libwebkit2gtk-4.0-37 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 下载并安装 Clash Verge .deb 包
RUN wget https://github.com/clash-verge-rev/clash-verge-rev/releases/download/v1.7.7/clash-verge_1.7.7_arm64.deb -O /tmp/clash-verge.deb && \
    dpkg -i /tmp/clash-verge.deb && \
    apt-get install -f -y && \
    rm /tmp/clash-verge.deb

# 将本地文件复制到容器
COPY /root /root

VOLUME /config/.local/share/io.github.clash-verge-rev.clash-verge-rev

EXPOSE 7897 9097

# 设置默认命令
CMD ["/usr/bin/clash-verge"]

