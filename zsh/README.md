## IGNORE some commands save to `~/.zsh_history`
```zsh
vim ~/.zsh_history
```

ex: IGNORE `terraform fmt *` to save into `~/.zsh_history`
`~/.zsh_history`
```zsh
export HISTORY_IGNORE="terraform fmt*"
setopt histignorespace
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
```

## Clean up some history from `~/.zsh_history`
> after exit shell or quit Terminal.App...
```zsh
LC_CTYPE=C sed '/^terraform \fmt/d' ~/.zsh_history > ~/.zsh_history.tmp \
&& cp ~/.zsh_history.tmp ~/.zsh_history
```

Ref:
- https://medium.com/@prasincs/hiding-secret-keys-from-shell-history-part-1-5875eb5556cc
- https://zsh.sourceforge.io/Doc/Release/Parameters.html#Parameters-Used-By-The-Shell
