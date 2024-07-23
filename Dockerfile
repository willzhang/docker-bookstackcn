FROM ghcr.io/puppeteer/puppeteer:22.13.1

ENV BOOKSTACK_VERSION=v2.12 \
    LANG=C.UTF-8 \
    QTWEBENGINE_CHROMIUM_FLAGS="--no-sandbox" \
    TZ=Asia/Shanghai

WORKDIR /www/wwwroot

USER root

RUN apt-get update && apt-get install -y --no-install-recommends \
    tzdata \
    git \
    ttf-wqy-zenhei \
    fonts-wqy-microhei \
    unzip \
    xz-utils \
    libegl1 \
    libopengl0 \
    libxcb-cursor0 \
    libgl1-mesa-glx \
    libglx0 \
    libegl1-mesa \
    libxrandr2 \
    libxrandr-dev \
    libxi6 \
    libxrender1 \
    libxext6 \
    libxfixes3 \
    libxtst6 \
    libxss1 \
    libxkbcommon-x11-0 \
    libxkbfile1 \
    && rm -rf /var/lib/apt/lists/* \
    && wget --no-check-certificate -qO /usr/local/bin/envsubst https://github.com/a8m/envsubst/releases/download/v1.4.2/envsubst-Linux-x86_64 \
    && chmod +x /usr/local/bin/envsubst \
    && wget --no-check-certificate -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sh /dev/stdin \
    && wget --no-check-certificate https://github.com/TruthHun/BookStack/releases/download/${BOOKSTACK_VERSION}/BookStack_${BOOKSTACK_VERSION}_Linux_amd64.zip \
    && unzip BookStack_${BOOKSTACK_VERSION}_Linux_amd64.zip \
    && chmod +x BookStack \
    && rm -rf BookStack_${BOOKSTACK_VERSION}_Linux_amd64.zip

COPY conf/ /tmp/conf
COPY entrypoint.sh /www/wwwroot/
RUN chmod +x /www/wwwroot/entrypoint.sh

VOLUME /www/wwwroot

EXPOSE 8181
CMD ["/www/wwwroot/entrypoint.sh"]
