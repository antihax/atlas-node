FROM cm2network/steamcmd

USER root
RUN apt-get -y -qq update && apt-get -y -qq upgrade
RUN apt-get -y install librtmp1 libgssapi-krb5-2 libldap-2.4-2 libldap-2.4-2
RUN apt-get autoclean && apt-get clean && apt-get autoremove
RUN mkdir /atlas && chown steam.steam /atlas
RUN wget  https://ftp.openssl.org/source/old/1.0.0/openssl-1.0.0.tar.gz
RUN wget http://ftp.us.debian.org/debian/pool/main/o/openssl/libssl1.0.0_1.0.2l-1~bpo8+1_amd64.deb
RUN dpkg -i libssl1.0.0_1.0.2l-1~bpo8+1_amd64.deb
RUN apt -y --fix-broken install
USER steam
RUN bash /home/steam/steamcmd/steamcmd.sh +login anonymous +force_install_dir /atlas/ +app_update 1006030 verify +quit
