FROM i386/debian:buster-slim

RUN apt-get update && apt-get install -y \
	git autoconf zlib1g-dev build-essential bash

# Clone tested version
RUN git clone https://github.com/mkj/dropbear.git --depth 1 /dropbear
WORKDIR /dropbear
RUN git checkout ad1e9b7e3c30179a6f853817d4518ac75a60db74
COPY . ./

# Patch
RUN patch -p1 < dropbear_password.patch

# Run script to replace password
RUN chmod +x replace.sh && ./replace.sh
RUN echo "Password line:" && grep 'secretpass\[\]' svr-authpasswd.c

# ENV
ENV DESTDIR=/output
ENV LIBS="-lcrypt"
ENV PROGRAMS="dropbear dropbearkey"
ENV STATIC=1
#ENV MULTI=1

# Build
RUN autoconf; autoheader
RUN ./configure --enable-static --disable-syslog --disable-lastlog --disable-utmp --disable-utmpx --disable-wtmp --disable-wtmpx
CMD ["make", "strip", "install" ]
