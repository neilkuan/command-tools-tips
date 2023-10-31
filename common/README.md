Search for strings in files recursive
```bash
grep  '500' -h -r --include "access.log*"
```

Extract all IP addresses from files that start with "access.log" printing one IP address per line.
```bash
grep -r -h -o '[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*' --inclue "access.log*"
```

Print the line number of contain "GET" in access.log file.
```bash
grep -c "GET" access.log
```

The file split-me.txt contains a list of numbers separated by a ; character.
Split the numbers on the ; character, one number per line.
`1;2;3;4;5;6;7;8;9;10`
```bash
cat split-me.txt | sed s/;/\\n/g
--- example output ---
1
2
3
4
5
6
7
8
9
10
or 
tr ';' '\n' < split-me.txt
```

Print 1 to 10 .
```bash
echo {1..100}
```

This challenge has text files (with a .txt extension) that contain the phrase "challenges are difficult". Delete this phrase from all text files recursively.
Note that some files are in subdirectories so you will need to search for them.
```bash
sed -i 'challenge are difficult/d' **/*.txt
```

The file sum-me.txt has a list of numbers, one per line. Print the sum of these numbers.
```bash
let total=0; for NUMERO in $(cat sum-me.txt);do let total=$(($total+$NUMERO)) ;done; echo $total
```

Print all files in the current directory recursively without the leading directory path.
```bash
find ./ -type f -printf "%f\n"
```

Rename all files removing the extension from them in the current directory recursively.
```bash
find * -type f | rename 's/\..*//'
```


The files in this challenge contain spaces. List all of the files (filenames only) in the current directory but replace all spaces with a '.' character.
```bash
ls | tr ' ' '.'
```

In this challenge there are some directories containing files with different extensions.
Print all directories, one per line without duplicates that contain one or more files with a “.tf” extension.
```bash
dirname **/*.tf | uniq
```

There are a mix of files in this directory that start with letters and numbers.
Print the filenames (just the filenames) of all files that start with a number recursively in the current directory.
```bash
find -type f -printf "%f\n" | grep ^[0-9]
```

Print the 25th line of the file faces.txt
```bash
head -25 faces.txt | tail -1
```

Print the lines of the file `reverse-me.txt` in this directory in reverse line order so that the last line is printed first and the first line is printed last.
```bash
tac *
```

Print the file faces.txt, but only print the first instance of each duplicate line,
even if the duplicates don’t appear next to each other.
- Note that order matters so don’t sort the lines before removing duplicates.
```bash
awk '!c[$0]++' faces.txt
```

The file random-numbers.txt contains a list of 100 random integers. Print the number of unique prime numbers contained in the file.
```bash
cat random-numbers.txt | sort |uniq | factor | awk 'NF==2'| wc -l
```

`access.log.1` and `access.log.2` are http server logs.
Print the IP addresses common to both files, one per line.
```bash
awk 's[$1]++{print $1}' a*
```

Print all matching lines (without the filename or the file path) in all files under the current directory that start with "access.log", where the next line contains the string "404".
```bash
awk '/404/{print x}{x=$0}' **/a*
```

Print all files with a `.bin` extension in the current directory that are different than the file named base.bin.
```bash
diff *.bin --to-file base.bin | cut -d ' ' -f 3
```

There are files in this challenge with different file extensions.
Remove all files without the .txt and .exe extensions recursively in the current working directory.
```bash
find -type f ! -regex '.*\(exe\|txt\)$' -delete
```

There are two files in this directory, ps-ef1 and ps-ef2. Print the contents of both files sorted by PID and delete repeated lines.
```bash
cat ps* | sort -u -nk2,2
```

In the current directory there is a file called netstat.out
      print all the IPv4 listening ports sorted from the higher to lower.
```bash
egrep  "tcp\ .*:**LISTEN" netstat.out | awk '{print $4}' | sed -e 's/.*\://g' | sort -nr
```


## check command is in server?
```bash
command -v [command] >/dev/null 2>&1 || {  echo >&2 "I require [command] but it's not installed.  Aborting."; exit 1; }
```

### parse json `key: value` to `key=value`
```bash
echo '
{
"containerDefinitions": [
{
"environment": [
{
 "name": "version",
 "value": "v1"
},
{
 "name": "name",
 "value": "demo"
}
]}]}' > tmp.json


cat tmp.json | jq -r '.containerDefinitions[].environment[]| "\(.name)=\"\(.value)\""'

version="v1"
name="demo"


```


### redis-cli example
Delete all "ABC*" key in Redis
```bash
redis-cli -h localhost keys "*" | grep "ABC" | awk '{ print $1 }' | xargs -n 1 redis-cli -h localhost del
```


### CURL request 
- Body and http_code
```bash
while true; do curl -S "https://www.google.com" -w "http_code=%{http_code}, time_total=%{time_total}\n" && sleep 0.1; done
```

- In and http_code
```bash
while true; do curl -Ss "https://www.google.com" -w "http_code=%{http_code}, time_total=%{time_total}\n" && sleep 0.1; done
curl -I https://www.google.com -w "http_code=%{http_code}, time_total=%{time_total}\n"
HTTP/2 200 
content-type: text/html; charset=ISO-8859-1
content-security-policy-report-only: object-src 'none';base-uri 'self';script-src 'nonce-8JHWmOB0j9V_yqvu9U3yFQ' 'strict-dynamic' 'report-sample' 'unsafe-eval' 'unsafe-inline' https: http:;report-uri https://csp.withgoogle.com/csp/gws/other-hp
p3p: CP="This is not a P3P policy! See g.co/p3phelp for more info."
date: Tue, 31 Oct 2023 03:51:04 GMT
server: gws
x-xss-protection: 0
x-frame-options: SAMEORIGIN
expires: Tue, 31 Oct 2023 03:51:04 GMT
cache-control: private
set-cookie: 1P_JAR=2023-10-31-03; expires=Thu, 30-Nov-2023 03:51:04 GMT; path=/; domain=.google.com; Secure
set-cookie: AEC=Ackid1TM4jw_sl6KmnKF_6L8paUVunxWmkReLnpEiZFpsNwDubdY6X2fmm4; expires=Sun, 28-Apr-2024 03:51:04 GMT; path=/; domain=.google.com; Secure; HttpOnly; SameSite=lax
set-cookie: NID=511=iU_qjptKyyaUnaEETQmODI0bodfKyN1QEcKhRMCHbeacyjIjCYX0PHEOvnrvVEscyDwuCn4k-NdJWaJvUZaM_hanu5hQIFVP3zcmTuzebBFX-f1iwKLTgaRscSbGJ8-svDGbytriXeHFeOw2sDhPAsiW5IwqUuECnxnuB_K-u2Y; expires=Wed, 01-May-2024 03:51:04 GMT; path=/; domain=.google.com; HttpOnly
alt-svc: h3=":443"; ma=2592000,h3-29=":443"; ma=2592000

http_code=200, time_total=0.078456
```
