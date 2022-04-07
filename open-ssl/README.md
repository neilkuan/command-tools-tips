
## How to Generate a Certificate Signing Request (CSR) With OpenSSL
> `csr` is txt.
> ref: https://phoenixnap.com/kb/generate-openssl-certificate-signing-request
```bash
openssl req -new -newkey rsa:2048 -nodes \
-out example_mycompany_com.txt \
-keyout example_mycompany_com.key \
-subj "/C=US/ST=TX/L=Irving/O=Hello Inc./OU=See www.entrust.net/legal-terms/CN=example.mycompany.com"
```
