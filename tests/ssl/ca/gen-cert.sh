#!/bin/sh
set -ex

# Adapted from:
# http://nodejs.org/api/tls.html
# https://github.com/joyent/node/blob/master/test/fixtures/keys/Makefile

# Create a private key
openssl genrsa -aes128 -out ca.key 4096 -passout 'pass:password'

# Create a certificate signing request

openssl req -new -nodes -sha256 -key ca.key -config ca.cnf -out ca.csr -days 3650 -passin 'pass:password'


# Use the CSR and the CA key (previously generated) to create a certificate
openssl x509 -req \
    -in ca.csr \
    -signkey ca.key \
    -passin 'pass:password' \
    -out ca.crt \
    -days 3650
