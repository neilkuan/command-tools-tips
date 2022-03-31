# Install kubectl plugin 
> ref: https://krew.sigs.k8s.io/docs/user-guide/setup/install/

## Bash or ZSH shells
```bash
# Make sure that git is installed.

# Run this command to download and install krew:

(
  set -x; cd "$(mktemp -d)" &&
  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
  KREW="krew-${OS}_${ARCH}" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
  tar zxvf "${KREW}.tar.gz" &&
  ./"${KREW}" install krew
)
# Add the $HOME/.krew/bin directory to your PATH environment variable. To do this, update your .bashrc or .zshrc file and append the following line:

# export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
# and restart your shell.

# Run kubectl krew to check the installation.
```

## kubectl krew install dds
```bash
$ kubectl krew install dds
Updated the local copy of plugin index.
Installing plugin: dds
Installed plugin: dds
\
 | Use this plugin:
 | 	kubectl dds
 | Documentation:
 | 	https://github.com/aws-containers/kubectl-detector-for-docker-socket
 | Caveats:
 | \
 |  | * If your docker socket is mounted at a different path name it will not
 |  | be checked.
 | /
/
WARNING: You installed plugin "dds" from the krew-index plugin repository.
   These plugins are not audited for security by the Krew maintainers.
   Run them at your own risk.

```
