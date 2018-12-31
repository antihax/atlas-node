FROM cm2network/steamcmd

USER root
RUN dpkg --add-architecture i386
RUN apt-get -y -qq update && apt-get -y -qq upgrade
RUN apt-get -y install ca-certificates wine wine32
RUN mkdir /atlas && chown steam.steam /atlas
USER steam
RUN bash /home/steam/steamcmd/steamcmd.sh +login anonymous +force_install_dir /atlas/ +app_update 1006030 verify +quit
