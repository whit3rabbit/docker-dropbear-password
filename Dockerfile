FROM amd64/debian:buster-slim

RUN apt-get update && apt-get install -y \
    git autoconf zlib1g-dev build-essential bash automake autotools-dev dos2unix

# Clone tested version
RUN git clone https://github.com/mkj/dropbear.git /dropbear
WORKDIR /dropbear
RUN git checkout 9dce15f33224c577f3b860481a0aa8d59063ebb4

# Patch
COPY dropbear_password.patch .
RUN dos2unix dropbear_password.patch
RUN git apply dropbear_password.patch || patch -p1 < dropbear_password.patch

RUN cp src/install-sh src/config.guess src/config.sub ./

# Run script to replace password
COPY replace.sh .
COPY password.txt .
COPY localoptions.h .
RUN dos2unix replace.sh localoptions.h password.txt
RUN chmod 755 /dropbear/replace.sh
RUN /bin/bash ./replace.sh | tee /tmp/replace_output.log && cat /tmp/replace_output.log

# ENV
ENV DESTDIR=/output
ENV LIBS="-lcrypt"
ENV PROGRAMS="dropbear"
#ENV CFLAGS="-g"
ENV STATIC=1
ENV ac_aux_dir=src
#ENV MULTI=1

# Build
RUN autoconf
RUN autoheader
RUN ./configure --enable-static --disable-syslog --disable-lastlog \
     --disable-utmp --disable-utmpx --disable-wtmp --disable-wtmpx
CMD ["make", "strip", "install" ]