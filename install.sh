# Install Asterisk

ASTERISK_VER='17.3.0'
INSTALL_SNGREP=true
apt-get update && \
   apt-get install -y autoconf build-essential libjansson-dev libxml2-dev libncurses5-dev libspeex-dev libcurl4-openssl-dev libedit-dev libspeexdsp-dev libgsm1-dev libsrtp0-dev uuid-dev sqlite3 libsqlite3-dev libspandsp-dev pkg-config python-dev openssl libopus-dev liburiparser-dev xmlstarlet curl wget && \
   apt-get clean && \
   rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

apt-get -y install aptitude

curl -o /tmp/asterisk.tar.gz http://downloads.asterisk.org/pub/telephony/asterisk/releases/asterisk-${ASTERISK_VER}.tar.gz && \
   tar xvf /tmp/asterisk.tar.gz -C /tmp/

cd /tmp/asterisk-${ASTERISK_VER} &&\
   ./contrib/scripts/install_prereq install &&\
   ./configure --with-pjproject-bundled --with-jansson-bundled --with-spandsp --with-opus && \
   make menuselect.makeopts && \
   menuselect/menuselect --disable CORE-SOUNDS-EN-GSM --enable CORE-SOUNDS-EN-ULAW --enable codec_opus --disable BUILD_NATIVE menuselect.makeopts && \
   make && \
   make install && \
   rm -Rf /tmp/*

# Add required runtime libs
apt-get update && \
   apt-get install -y gnupg libjansson4 xml2 libncurses5 libspeex1 libcurl4-openssl-dev libedit2 libspeexdsp1 libgsm1 uuid libsqlite3-0 libspandsp2 libopus0 liburiparser1 xmlstarlet curl wget && \
   apt-get clean && \
   rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add sngrep
if [ ${INSTALL_SNGREP} = true ]; then
	apt-get update && \
	   apt-get install -y sngrep && \
	   rm -Rf /var/lib/apt/lists/ /tmp/* /var/tmp/*
fi
