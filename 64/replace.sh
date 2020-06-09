#!/bin/bash

PASS=`cat password.txt`
sed -i s"/sup3rs3cr3tpassw0rd/${PASS}/g" svr-authpasswd.c
