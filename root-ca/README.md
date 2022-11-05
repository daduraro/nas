# Root CA

Following guide from https://jamielinux.com/docs/openssl-certificate-authority/index.html

## Prepare file structure

```console 
# mkdir ca
# mkdir ca/certs ca/crl ca/newcerts ca/private
# chmod 700 ca/private
# touch ca/index.txt
# echo 1234 > ca/serial
```

## Generate key

```console
# openssl ecparam -name prime256v1 -genkey -noout -out ca.ec.key
# openssl pkcs8 -topk8 -in ca.ec.key -out ca/private/ca.key.pem
# chmod 400 ca/private/ca.key.pem
# rm ca.ec.key
```

## Create root CA certificate

```console
# openssl req -config openssl.cnf \
      -key ca/private/ca.key.pem \
      -new -x509 -days 3650 -sha256 -extensions v3_ca \
      -subj "/CN=Test CA/C=AD/O=Test CA org" \
      -out ca/certs/ca.cert.pem
# chmod 444 ca/certs/ca.cert.pem
```

### Verify root CA certificate (optional)

```console
# openssl x509 -noout -text -in ca/certs/ca.cert.pem
```

# Server certificate

## Generate key

```console
# openssl ecparam -name prime256v1 -genkey -noout -out srv.key.pem
```

## Create CSR

```console
# openssl req -config openssl.cnf \
      -key srv.key.pem \
      -new -sha256 -out srv.csr.pem \
      -subj "/CN=testca.org/C=AD/O=Test CA org" \
      -addext "subjectAltName = DNS:testca.org,DNS:*.testca.org"
```

## Sign CSR with root certificate

```console
# openssl ca -config openssl.cnf \
      -extensions server_cert -days 1825 -notext -md sha256 \
      -in srv.csr.pem \
      -out srv.cert.pem
```

### Verify the certificate (optional)

```console
# openssl x509 -noout -text -in srv.cert.pem
```

# Install root certificate to ArchLinux

```console
$ scp <user>@<server>:/path/to/ca/certs/ca.cert.pem .
# trust anchor --store ca.cert.pem
```
