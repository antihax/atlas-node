FROM cm2network/steamcmd

USER root
RUN apt-get -y -qq update \
 && apt-get -y -qq upgrade \
 && apt-get -y install librtmp1 libgssapi-krb5-2 libldap-2.4-2 libldap-2.4-2 wget multiarch-support libprotobuf-dev \
 && wget http://security.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.0.0_1.0.2g-1ubuntu4.16_amd64.deb \
 && wget http://ftp.us.debian.org/debian/pool/main/p/protobuf/libprotobuf10_3.0.0-9_amd64.deb \
 && wget http://ftp.us.debian.org/debian/pool/main/libi/libidn/libidn11_1.33-2.4_amd64.deb \
 && dpkg -i libssl1.0.0_1.0.2g-1ubuntu4.16_amd64.deb \
 && dpkg -i libprotobuf10_3.0.0-9_amd64.deb \
 && dpkg -i libidn11_1.33-2.4_amd64.deb \
 && apt -y --fix-broken install \
 && apt-get autoclean && apt-get clean && apt-get autoremove \
# && rm libssl1.0.0_1.0.2l-1~bpo8+1_amd64.deb \
 && rm -rf /var/lib/apt/lists/*
RUN mkdir /atlas && chown steam.steam /atlas
COPY run.sh /
RUN chmod 755 /run.sh
USER steam
RUN bash /home/steam/steamcmd/steamcmd.sh +login anonymous +force_install_dir /atlas/ +app_update 1006030 verify +quit
