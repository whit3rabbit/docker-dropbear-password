# What is this?

Build a dropbear ssh server with a hardcoded password that run in the current users context.

* Docker for easy building/output
* Easily change password
* Different architectures
* Changed pid/key folders to tmp (this can be changed with flags)

This was built for CTF/lab environments where I might not know the current users password but want a full TTY shell.

Changes were based on this article: https://www.welivesecurity.com/2016/01/03/blackenergy-sshbeardoor-details-2015-attacks-ukrainian-news-media-electric-industry/

## How to build for x86
```
cd x86
# Modify password.txt with password you want
docker build -t dropbearx86 .
docker run -v ${PWD}/output:/output -it dropbearx86
# Dropbear will be in output folder: output/usr/local/sbin/dropbear
```
## How to build for 64 bit
```
cd 64
# Modify password.txt with password you want
docker build -t dropbear64 .
docker run -v ${PWD}/output:/output -it dropbear64
# Files will be in output folder
```

## Prerequisites

Install docker

## Testing Dropbear

```
mkdir -p /tmp/.disk-lock # Temporary directory for generating SSH keys (default: keys folder)
./dropbear -R -F -p 1337 # -R generates keys // -F foreground // -p port #
```