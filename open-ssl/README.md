
### How to Generate a Certificate Signing Request (CSR) with OpenSSL
> `csr` is txt.
> ref: https://phoenixnap.com/kb/generate-openssl-certificate-signing-request
```bash
openssl req -new -newkey rsa:2048 -nodes \
-out example_mycompany_com.txt \
-keyout example_mycompany_com.key \
-subj "/C=US/ST=TX/L=Irving/O=Hello Inc./OU=See www.entrust.net/legal-terms/CN=example.mycompany.com"
```

### How to check expire date with OpenSSL
`-connect`
```bash
openssl s_client -connect google.com:443 2>/dev/null | openssl x509 -noout -dates
---
notBefore=Jan  1 00:00:00 2015 GMT
notAfter=Jan  1 00:00:00 2030 GMT
```
`local-file`
```bash
openssl x509 -in ./tls.crt -text -noout | grep "Not After"
---
Not After : May 19 02:29:36 2024 GMT
```

### How to check the subject alternative name of CA with OpenSSL

```bash
openssl x509 -inform pem -text | grep -A1 "Subject Alternative Name"
---
    X509v3 Subject Alternative Name: 
        DNS:amazon.co.uk, DNS:uedata.amazon.co.uk, DNS:www.amazon.co.uk, DNS:origin-www.amazon.co.uk, DNS:*.peg.a2z.com, DNS:amazon.com, DNS:amzn.com, DNS:uedata.amazon.com...
```
