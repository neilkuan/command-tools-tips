
## How to Generate a Certificate Signing Request (CSR) With OpenSSL
> `csr` is txt.
> ref: https://phoenixnap.com/kb/generate-openssl-certificate-signing-request
```bash
openssl req -new -newkey rsa:2048 -nodes \
-out lares-stg_trendmicro_com.txt \
-keyout lares-stg_trendmicro_com.key \
-subj "/C=US/ST=TX/L=Irving/O=Hello Inc./OU=See www.entrust.net/legal-terms/CN=example.mycompany.com"
```
