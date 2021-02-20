FROM ubuntu

ENV CALIBRE_URL=https://raw.githubusercontent.com/kovidgoyal/calibre/master/setup/linux-installer.py \
    BOOKSTACK_VER=v2.0 \
    BOOKSTACK_PKG=2019-08-18.BookStack.V2.0_Linux_amd64.zip

RUN apt-get update -qqy \
  && apt-get install -y ttf-wqy-zenhei fonts-wqy-microhei \
  && apt-get install -y wget unzip git python xdg-utils xz-utils imagemagick \
  ###install calibre
  && wget -nv -O- ${CALIBRE_URL} | python -c "import sys; main=lambda:sys.stderr.write('Download failed\n'); exec(sys.stdin.read()); main()";exit 0 \
  && rm -rf /tmp/calibre-installer-cache \
  ###install google-chrome
  && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
  && apt-get install -y google-chrome-stable \
  && rm -rf /etc/apt/sources.list.d/google-chrome.list \
  ###install bookstack
  && mkdir /opt/bookstack/ \
  && cd /opt/bookstack/ \
  && wget https://github.com/TruthHun/BookStack/releases/download/${BOOKSTACK_VER}/${BOOKSTACK_PKG} \
  && unzip ${BOOKSTACK_PKG} \
  && chmod +x BookStack \
  && rm -rf ${BOOKSTACK_PKG} \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/* \
  && apt-get clean

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

WORKDIR /opt/bookstack/
EXPOSE 8181

ENTRYPOINT [ "/entrypoint.sh" ]
