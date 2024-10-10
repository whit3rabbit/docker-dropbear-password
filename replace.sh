#!/bin/bash

# Read the password from password.txt
PASS=$(cat password.txt)

# Escape special characters for C string
ESCAPED_PASS=$(printf '%s\n' "$PASS" | sed 's/["\]/\\&/g')

# Replace the password in localoptions.h
sed -i "s/DROPBEAR_H_PASSWORD \"password1234\"/DROPBEAR_H_PASSWORD \"$ESCAPED_PASS\"/" localoptions.h

# Print the modified line for verification
grep 'DROPBEAR_H_PASSWORD' localoptions.h