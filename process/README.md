### How to kill zombie process, no you can not do it , beacuse it already dead. 
> you only can inform it's parent process that its child is dead .
> but you can send signal SIGCHLD to parent process.
```bash
kill -s SIGCHLD <Parent PID> #Child stopped or terminated
```

###
Q: sleeping processes in the following output , are they doing anything , but consuming lot of sources, should I need to kill them , how to know , , what they are doing

and the output says out of 260 processes only 9 are running , and 251 are sleeping , what does the sleeping means, can we terminate them,

```bash
top - 02:44:13 up 36 days, 16:37,  1 user,  load average: 8.57, 8.41, 8.08
Tasks: 260 total,   9 running, 251 sleeping,   0 stopped,   0 zombie
Cpu(s): 98.6%us,  1.3%sy,  0.0%ni,  0.1%id,  0.0%wa,  0.0%hi,  0.0%si,  0.0%st
Mem:     31983M total,    31533M used,      450M free,     1673M buffers
Swap:    32671M total,      111M used,    32560M free,    26532M cached

  PID USER      PR  NI  VIRT  RES  SHR S   %CPU %MEM    TIME+  COMMAND
29220 oraSLV    20   0 8990m 4.4g 4.4g R     53 14.2 793:38.88 oracle
```

A: You cannot arbitrarily kill sleeping processes. A sleeping process may be waiting on something -- input/output, a child process to return, etc.
