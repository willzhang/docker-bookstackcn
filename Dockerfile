FROM ghcr.io/puppeteer/puppeteer:22.13.1
ENV BOOKSTACK_VERSION=v2.12 \
    LANG=C.UTF-8 \
    QTWEBENGINE_CHROMIUM_FLAGS="--no-sandbox"

WORKDIR /bookstack

USER root

RUN apt update -y
RUN apt install -y tzdata git
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN apt install -y ttf-wqy-zenhei fonts-wqy-microhei
RUN apt install -y unzip xz-utils
RUN wget -qO /usr/local/bin/envsubst https://github.com/a8m/envsubst/releases/download/v1.4.2/envsubst-Linux-x86_64  
RUN chmod +x /usr/local/bin/envsubst
RUN apt install -y libegl1
RUN apt install -y libopengl0
RUN apt install -y libxcb-cursor0
RUN wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sh /dev/stdin
RUN wget https://github.com/TruthHun/BookStack/releases/download/${BOOKSTACK_VERSION}/BookStack_${BOOKSTACK_VERSION}_Linux_amd64.zip
RUN unzip BookStack_${BOOKSTACK_VERSION}_Linux_amd64.zip
RUN chmod +x BookStack
RUN rm -rf BookStack_${BOOKSTACK_VERSION}_Linux_amd64.zip
RUN rm -rf /var/lib/apt/lists/* /var/cache/apt/*

COPY conf/ /tmp/conf

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
EXPOSE 8181
CMD ["/bookstack/BookStack"]
