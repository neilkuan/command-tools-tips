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
``bash
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
