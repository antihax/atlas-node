FROM debian:bookworm-slim AS install-stage
LABEL maintainer="antihax@gmail.com"

ARG UNAME=steam
RUN groupadd -g 1000 -o ${UNAME}
RUN useradd -u 1000 -g 1000 -d /home/${UNAME} -m -s /bin/bash ${UNAME}
ENV HOME /home/${UNAME}
ENV DEBIAN_FRONTEND noninteractive

WORKDIR /home/${UNAME}
COPY scripts/* /

RUN dpkg --add-architecture i386 \
 && apt-get -y -qq update \
 && apt-get -y -qq upgrade \
 && apt-get -y -qq install curl lib32stdc++6 lib32gcc-s1 locales gnupg xvfb xterm wine winbind \
 && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
 && dpkg-reconfigure --frontend=noninteractive locales \
 && curl -fsSL 'https://dl.winehq.org/wine-builds/winehq.key' | apt-key add - \
 && update-locale LANG=en_US.UTF-8 \
 && apt-get autoclean && apt-get clean && apt-get autoremove \
 && rm -rf /var/lib/apt/lists/* \
 && chmod 755 /install-server \
 && chmod 755 /start-server

FROM install-stage
ARG UNAME=steam
USER ${UNAME}
ENV WINEPREFIX /home/${UNAME}/.wine
ENV WINEARCH win64
ENV WINEDEBUG -all

RUN mkdir -p ${HOME} \
 && curl -fsSL 'https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz' | tar -xz \
 && /home/${UNAME}/steamcmd.sh +login anonymous +quit
CMD /home/${UNAME}/steamcmd.sh 